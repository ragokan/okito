import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../okito.dart';

class AppController extends OkitoController {
  // Material
  ThemeData? themeData;
  ThemeMode? themeMode;
  void setThemeData(ThemeData newThemeData) =>
      setState(() => themeData = newThemeData);
  void setThemeMode(ThemeMode newThemeMode) =>
      setState(() => themeMode = newThemeMode);

  // Cupertino
  CupertinoThemeData? cupertinoThemeData;

  void setCupertinoThemeData(CupertinoThemeData newCupertinoThemeData) =>
      setState(() => cupertinoThemeData = newCupertinoThemeData);

  // Both
  Locale? locale;
  void setLocale(Locale newLocale) => setState(() => locale = newLocale);
}
