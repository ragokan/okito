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
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Rockito<CounterController>(
            (controller) => Text('Current count is ${controller.count}'),
          ),
        ),
        body: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: Okito.use<CounterController>().increment,
                  child: const Text('Increment'),
                ),
                OtherWidget(),
                ElevatedButton(
                  onPressed: () => Okito.use<CounterController>()
                      .setState(() => Okito.use<CounterController>().count--),
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
  @override
  Widget build(_) => Rockito<CounterController>((c) => Text('${c.count}'));
}
