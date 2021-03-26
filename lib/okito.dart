import 'package:flutter/material.dart';
import 'modules/builder.dart';
import 'modules/controller.dart';

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
              callback: () {
                print('rerender');
                return Text(counterController.count.toString());
              },
              controller: counterController),
        ),
        body: Center(
          child: Container(
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: counterController.increment,
                  child: const Text('Increment'),
                ),
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
