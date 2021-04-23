import 'dart:async';

import 'package:flutter/material.dart';
import 'package:okito/okito.dart';

StreamController<int> streamController = StreamController();

class CounterController extends OkitoController with OkitoStreamMixin {
  int count = 0;

  @override
  void onInject() {
    initStream<int>(
        stream: streamController.stream,
        onData: (data) {
          count = data;
        });
  }
}

void main() async {
  Okito.inject(CounterController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(_) => MaterialApp(title: 'Flutter Demo', home: MyHomePage());
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(_) => Scaffold(
      appBar: AppBar(title: const Text('Okito <3 Streams')),
      body: Center(child: Rockito<CounterController>((d) {
        return Text('You have pushed the button this many times: ${d.count}');
      })),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            streamController.add((Okito.use<CounterController>().count + 1));
          },
          child: const Icon(Icons.add)));
}
