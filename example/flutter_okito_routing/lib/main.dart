import 'package:flutter/material.dart';
import 'package:okito/okito.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OkitoMaterialApp(
      title: 'Material App',
      routes: {
        '/': (_) => const PageOne(),
        '/second': (_) => const PageTwo(),
        '/third': (_) => const PageThree(),
      },
    );
  }
}

class PageOne extends StatelessWidget {
  const PageOne({Key? key}) : super(key: key);

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
  const PageTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Page Two'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              // navi.pushReplacementNamed('/third');
              Okito.pushEasy(const PageThree());
            },
            child: const Text('Go to page 3'),
          ),
        ),
      );
}

class PageThree extends StatelessWidget {
  const PageThree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Page Three'),
        ),
      );
}
