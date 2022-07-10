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

CounterController counterController = CounterController();

void main() {
  runApp(const CounterApp());
  // You can change state from anywhere
  Future.delayed(const Duration(seconds: 3), () {
    counterController.increment();
  });
}

class CounterApp extends StatelessWidget {
  const CounterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: OkitoBuilderLite<CounterController>(
            filter: (c) => c.count,
            controller: counterController,
            builder: () => Text('Current count is ${counterController.count}'),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: counterController.increment,
                child: const Text('Increment'),
              ),
              const OtherWidget(),
              ElevatedButton(
                onPressed: () =>
                    counterController.setState(() => counterController.count--),
                child: const Text('Decrement'),
              ),
            ],
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
      controller: counterController,
      builder: () => Text('Second widget: ${counterController.count}'),
    );
  }
}
