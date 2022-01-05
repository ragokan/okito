import 'package:flutter/material.dart';
import 'package:okito/okito.dart';

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
  runApp(CounterApp());
}

class CounterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counterController = Okito.use<CounterController>();
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: OkitoBuilder(
            controller: counterController,
            builder: () => Text('Current count is ${counterController.count}'),
          ),
        ),
        body: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: counterController.increment,
                  child: const Text('Increment'),
                ),
                const OtherWidget(),
                ElevatedButton(
                  onPressed: () => counterController
                      .setState(() => counterController.count--),
                  child: const Text('Decrement'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OtherWidget extends StatelessWidget {
  const OtherWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OkitoBuilder(
      controller: Okito.use<CounterController>(),
      builder: () =>
          Text('Second widget: ${Okito.use<CounterController>().count}'),
    );
  }
}
