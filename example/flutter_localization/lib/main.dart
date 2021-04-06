import 'package:flutter/material.dart';
import 'package:okito/okito.dart';

void main() => runApp(MyApp());

const translations = {
  'en': {
    'hello': 'Hello from Okito!',
    'hello_world': 'Okito says Hello World in English!',
  },
  'tr': {
    'hello': "Okito'dan selamlar!",
    'hello_world': 'Okito size Türkçe olarak merhaba dünya diyor!',
  },
};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const OkitoMaterialApp(
        title: 'Material App',
        home: HomePage(),
        translations: translations,
        locale: Locale('en', 'EN'),
      );
}

class HomePage extends StatelessWidget {
  const HomePage();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('hello'.loc),
        ),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text('hello_world'.loc),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () => Okito.app.setLocale(const Locale('en', 'EN')),
                child: const Text('Set language to English')),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () => Okito.app.setLocale(const Locale('tr', 'TR')),
                child: const Text('Set language to Turkish'))
          ]),
        ),
      );
}
