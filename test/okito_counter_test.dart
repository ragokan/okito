import 'package:flutter_test/flutter_test.dart';
// ignore: avoid_relative_lib_imports
import '../example/flutter_counter/lib/main.dart';

/// This controls the main widget.
void controlCountInMain(int count) =>
    expect(find.text('Current count is $count'), findsOneWidget);

/// This controls the secondary widget.
void controlCountInSecondWidget(int count) =>
    expect(find.text('Second widget: $count'), findsOneWidget);

/// And this one actually runs both with current [count].
void control(int count) {
  controlCountInMain(count);
  controlCountInSecondWidget(count);
}

void main() {
  testWidgets('Counter test with okito', (WidgetTester tester) async {
    // Build app
    await tester.pumpWidget(CounterApp());

    // Check the screen for count:0
    control(0);

    final incrementButton = find.text('Increment');
    final decrementButton = find.text('Decrement');

    // Increase Count
    await tester.tap(incrementButton);
    await tester.pump();
    control(1);

    // Decrease Count
    await tester.tap(decrementButton);
    await tester.pump();
    control(0);

    // Do crazy tests
    for (var i = 0; i < 100; i++) {
      await tester.tap(incrementButton);
    }
    await tester.pump();
    control(100);

    // Do more tests
    for (var i = 0; i < 100; i++) {
      await tester.tap(decrementButton);
    }
    await tester.pump();
    control(0);
  });
}
