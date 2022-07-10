import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../okito.dart';
import '../okito_utilities/route_utilities/dynamic_routing.dart';

/// The root controller of [OkitoMaterialApp] and [OkitoCupertinoApp].
///
/// This controller is already injected to the Okito. You can use it by
/// ```dart
/// Okito.app
/// //or
/// Okito.use<AppController>()
/// ```
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

  /// Updates the current [cupertinoThemeData] of your app, then re-builds
  ///  your app, so that your changes will be seen in the screen. If you don't
  ///  want a re-build , you can directly set [cupertinoThemeData].
  void setCupertinoThemeData(CupertinoThemeData newCupertinoThemeData) =>
      setState(() => cupertinoThemeData = newCupertinoThemeData);

  // Both
  /// Returns [locale] of your app.
  Locale? locale;

  /// A fallback locale if there are no given locale or the locale provided
  /// is not found in the translations.
  Locale fallbackLocale = const Locale('en', 'US');

  /// The [translations] of your app.
  ///
  /// Example translation:
  ///
  /// ```dart
  /// const translations = {
  ///   'en': {
  ///     'hello': 'Hello from Okito!',
  ///   },
  ///   'tr': {
  ///     'hello': "Okito'dan selamlar!",
  ///   },
  /// };
  /// ```
  Map<String, Map<String, String>> translations = const {};

  /// Updates the current [locale] of your app, then re-builds your app, so that
  /// your changes will be seen in the screen. If you don't want a re-build, you
  /// can directly set [locale].
  void setLocale(Locale newLocale) {
    locale = newLocale;

    /// Reason of using this is updating the material/cupertino app is not
    /// enough to update all the strings, we do this and update everything.
    _widgetsBindingInstance.reassembleApplication();
  }

  /// Returns the current app, if you used [OkitoMaterialApp], it will be true,
  /// if you used [OkitoCupertinoApp], it will be false.
  ///
  /// We do use this parameter in routing animations.
  bool isMaterial = true;

  /// These [routes] are the main [routes] of the [OkitoMaterialApp] or
  /// [OkitoCupertinoApp], we don't do any change here, we just save it.
  ///
  /// The reason of saving here is dynamic routing in [onGenerateRoute];
  Map<String, Widget Function(BuildContext)> routes =
      const <String, WidgetBuilder>{};

  /// When user tries to go to a dynamic route such as ['/users/31'] and
  /// we have ['/users/:id'] on [routes], Flutter wont be able to identify
  /// the correct route and [onGenerateRoute] function will be evaluated.
  ///
  /// We will use [pageRouteBuilder] method to find the route and give it
  /// the required params.
  Route<dynamic>? onGenerateRoute(RouteSettings settings) =>
      pageRouteBuilder(settings);

  /// Firstly, thanks 'Stackoverflow' for showing this usage.
  ///
  /// This is the [WidgetsBinding] of the app.
  ///
  /// We can use it like: [widgetsBindingInstance!.reassembleApplication()]
  WidgetsBinding get _widgetsBindingInstance {
    return WidgetsBinding.instance;
  }
}
