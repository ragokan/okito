import 'package:flutter_test/flutter_test.dart';
import 'package:okito/okito.dart';

class CounterController extends OkitoController {
  int count = 0;

  void increment() => setState(() => count++);

  void decrement() {
    count--;
    update();
  }
}

CounterController counterController = CounterController();

void main() {
  test('okito_watcher', () {
    final stopWatching = OkitoWatcher(
      watch: counterController,
      onChange: (CounterController controller) {
        /// You can also update the state there, the controller it gives to
        /// you is the instance of controller.
        print(controller.count);

        expect(counterController.count, 1);
        expect(controller.count, 1);
        expect(controller.count, counterController.count);
      },
    );

    counterController.increment();
    expect(counterController.count, 1);

    stopWatching();
  });
}
