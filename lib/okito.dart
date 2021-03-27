import 'package:flutter/material.dart';
import 'bin/builder.dart';
import 'bin/controller.dart';

class CounterController extends OkitoController {
  int count = 0;

  void increment() => setState(() => count++);
}

CounterController counterController = CounterController();

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: OkitoBuilder(
            builder: () => Text('Current count is ${counterController.count}'),
            controller: counterController,
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
      builder: () => Text(
        '${counterController.count}',
        style: const TextStyle(fontSize: 30),
      ),
      controller: counterController,
    );
  }
}
