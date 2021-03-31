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
  OkitoWatcher<CounterController>(
    watch: counterController,
    onChance: (state) {
      print(state.count);
    },
  );

  counterController.increment();
}
