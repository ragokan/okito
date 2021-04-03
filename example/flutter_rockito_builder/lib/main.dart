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
  runApp(CounterApp());
}

class CounterApp extends StatelessWidget {
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
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: Okito.take<CounterController>().increment,
                  child: const Text('Increment'),
                ),
                const OtherWidget(),
                ElevatedButton(
                  onPressed: () => Okito.take<CounterController>()
                      .setState(() => Okito.take<CounterController>().count--),
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
    return Column(
      children: [
        RockitoBuilder<CounterController>(builder: (c) => Text('${c.count}')),
      ],
    );
  }
}
