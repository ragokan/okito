import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../okito.dart';
import '../okito_utilities/route_utilities/dynamic_routing.dart';

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

  // TODO: add info
  bool isMaterial = true;

  // TODO: add info
  Map<String, Widget Function(BuildContext)> routes =
      const <String, WidgetBuilder>{};

  // TODO: add info
  Route<dynamic>? onGenerateRoute(RouteSettings settings) =>
      pageRouteBuilder(settings);
}
