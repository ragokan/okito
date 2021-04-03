import 'package:flutter/material.dart';
import 'package:okito/okito.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OkitoMaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Okito Widgets'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () => Okito.showModal(
                      child: Container(
                          height: 300,
                          child: const Center(child: Text('Okito Modal!')))),
                  child: const Text('Show Bottom Modal')),
              const SizedBox(height: 30),
              ElevatedButton(
                  onPressed: () => Okito.showSnackBar(
                      snackBar:
                          const SnackBar(content: Text('Okito Snackbar'))),
                  child: const Text('Show Snackbar')),
              const SizedBox(height: 30),
              ElevatedButton(
                  onPressed: () => Okito.showDialog(
                          child: Scaffold(
                        appBar: AppBar(title: const Text('Okito Dialog')),
                      )),
                  child: const Text('Show Dialog')),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => Okito.showToast(text: 'Okito Toast'),
                child: const Text('Show Dialog'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
