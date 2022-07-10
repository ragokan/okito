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
  runApp(const CounterApp());
}

class CounterApp extends StatelessWidget {
  const CounterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: RockitoBuilder<CounterController>(
            inject: CounterController(),
            builder: (controller) =>
                Text('Current count is ${controller.count}'),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: Okito.use<CounterController>().increment,
                child: const Text('Increment'),
              ),
              const OtherWidget(),
              ElevatedButton(
                onPressed: () => Okito.use<CounterController>()
                    .setState(() => Okito.use<CounterController>().count--),
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
    return Column(
      children: [
        RockitoBuilder<CounterController>(builder: (c) => Text('${c.count}')),
      ],
    );
  }
}
