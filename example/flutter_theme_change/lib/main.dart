import 'package:flutter/material.dart';
import 'package:okito/okito.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const OkitoMaterialApp(
      title: 'Material App',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material App Bar'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Color primaryColor = Okito.theme.primaryColor == Colors.blue
                    ? Colors.red
                    : Colors.blue;
                Okito.app.setThemeData(
                  ThemeData(
                    primaryColor: primaryColor,
                    elevatedButtonTheme: ElevatedButtonThemeData(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(primaryColor),
                      ),
                    ),
                  ),
                );
              },
              child: const Text('Change App Color'),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => Okito.app.setThemeData(
                Okito.isDarkMode
                    ? ThemeData(
                        brightness: Brightness.light,
                        primaryColor: Okito.theme.primaryColor,
                        elevatedButtonTheme: ElevatedButtonThemeData(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Okito.theme.primaryColor),
                          ),
                        ))
                    : ThemeData(
                        brightness: Brightness.dark,
                        primaryColor: Okito.theme.primaryColor,
                        elevatedButtonTheme: ElevatedButtonThemeData(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Okito.theme.primaryColor),
                          ),
                        )),
              ),
              child: const Text('Change App Mode'),
            ),
          ],
        ),
      ),
    );
  }
}
