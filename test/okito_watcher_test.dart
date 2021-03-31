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
  final stopWatching = OkitoWatcher(
    watch: counterController,
    onChange: (CounterController controller) {
      // You can also update the state there, the controller it gives to you is
      // the instance of controller.
      print(controller.count);
    },
  );

  counterController.increment();

  stopWatching();
}
