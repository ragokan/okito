import 'package:flutter/material.dart';
import 'package:okito/okito.dart';

final box = OkitoStorage;

void main() async {
  await box.init(storageName: 'my_okito_app');
  runApp(MyApp());
}

class Numbers extends OkitoController {
  List values = box.read('numbers') ?? [];
  Numbers() {
    box.watchKey('numbers', () {
      values = box.read('numbers') ?? [];
      print('Numbers are changed, new numbers are $values');
    });
  }
}

Numbers numbers = Numbers();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OkitoBuilder(
              controller: numbers,
              watchStorageKeys: ['numbers'],
              builder: () => Text(
                box.read('numbers').toString(),
                style: const TextStyle(fontSize: 20),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                numbers.values.add(numbers.values.length);
                box.write(
                  'numbers',
                  numbers.values,
                );
              },
              child: const Text('Add Number'),
            ),
            ElevatedButton(
              onPressed: () {
                box.write(
                  'numbers',
                  [],
                );
              },
              child: const Text('Clear Numbers'),
            ),
          ],
        )),
      ),
    );
  }
}
