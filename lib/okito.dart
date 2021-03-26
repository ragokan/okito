import 'modules/controller.dart';

class CounterController extends OkitoController {
  int count = 0;

  void increment() => setState(() => count++);
}

CounterController counter = CounterController();

void main() {
  print('here we go');
}
