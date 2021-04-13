import 'package:flutter_test/flutter_test.dart';
import 'package:okito/okito.dart';
import 'package:okito/src/okito_state_management/rockito_watcher.dart';

class CounterController extends OkitoController {
  int count = 0;

  void increment() => setState(() => count++);

  void decrement() {
    count--;
    update();
  }
}

void main() {
  Okito.inject(CounterController());
  test('okito_watcher', () {
    RockitoWatcher<CounterController>(
      (controller) {
        /// You can also update the state there, the controller it gives to
        /// you is the instance of controller.
        print(controller.count);

        expect(controller.count, 1);
      },
    );

    Okito.use<CounterController>().increment();
  });
}
