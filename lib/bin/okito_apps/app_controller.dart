import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../okito.dart';

class AppController extends OkitoController {
  // Material
  /// Returns your [themeData] but it can be null if you didn't set it yet.
  ThemeData? themeData;

  /// Returns your [themeMode] but it can be null if you didn't set it yet.
  ThemeMode? themeMode;

  /// Updates the current [themeData] of your app, then re-builds your app,
  /// so that your changes will be seen in the screen. If you don't want a
  /// re-build , you can directly set [themeData].
  void setThemeData(ThemeData newThemeData) =>
      setState(() => themeData = newThemeData);

  /// Updates the current [themeMode] of your app, then re-builds your app,
  /// so that your changes will be seen in the screen. If you don't want a
  /// re-build , you can directly set [themeMode].
  void setThemeMode(ThemeMode newThemeMode) =>
      setState(() => themeMode = newThemeMode);

  // Cupertino
  /// Returns your [cupertinoThemeData] but it can be null
  /// if you didn't set it yet.
  CupertinoThemeData? cupertinoThemeData;

  void setCupertinoThemeData(CupertinoThemeData newCupertinoThemeData) =>
      setState(() => cupertinoThemeData = newCupertinoThemeData);

  // Both
  /// Returns [locale] of your app.
  Locale? locale;

  /// Updates the current [locale] of your app, then re-builds your app, so that
  /// your changes will be seen in the screen. If you don't want a re-build, you
  /// can directly set [locale].
  void setLocale(Locale newLocale) => setState(() => locale = newLocale);
}
