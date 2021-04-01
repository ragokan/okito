import 'package:flutter/material.dart';
import 'package:okito/okito.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OkitoMaterialApp(
      title: 'Material App',
      routes: {
        '/': (_) => PageOne(),
        '/second': (_) => PageTwo(),
        '/third': (_) => PageThree(),
      },
    );
  }
}

class PageOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Page One'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              Okito.pushNamed('/second', arguments: 'Anan');
            },
            child: Text('Go to page 2 - Width: ${Okito.width}'),
          ),
        ),
      );
}

class PageTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Page Two'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              // navi.pushReplacementNamed('/third');
              Okito.pushEasy(PageThree());
            },
            child: const Text('Go to page 3'),
          ),
        ),
      );
}

class PageThree extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Page Three'),
        ),
      );
}
