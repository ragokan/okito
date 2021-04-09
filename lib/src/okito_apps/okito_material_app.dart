import 'package:flutter/material.dart';

import '../../okito.dart';
import '../okito_instance.dart';
import '../okito_utilities/okito_observer.dart';
import 'app_controller.dart';

// TODO: Add documents here.

/// [OkitoMaterialApp] is the replacement of [MaterialApp] to use
/// all of [Okito] features in your app!
class OkitoMaterialApp extends StatelessWidget {
  const OkitoMaterialApp({
    Key? key,
    this.scaffoldMessengerKey,
    this.home,
    Map<String, WidgetBuilder> this.routes = const <String, WidgetBuilder>{},
    this.initialRoute,
    this.onGenerateInitialRoutes,
    this.onUnknownRoute,
    this.routeInformationProvider,
    this.routeInformationParser,
    this.routerDelegate,
    this.backButtonDispatcher,
    this.builder,
    this.title = 'Okito App',
    this.onGenerateTitle,
    this.theme,
    this.darkTheme,
    this.highContrastTheme,
    this.highContrastDarkTheme,
    this.themeMode = ThemeMode.system,
    this.color,
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.showPerformanceOverlay = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = true,
    this.shortcuts,
    this.actions,
    this.restorationScopeId,
    this.debugShowMaterialGrid = false,
    this.checkerboardRasterCacheImages = false,
    this.checkerboardOffscreenLayers = false,
    this.translations = const {},
  });

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
  final Map<String, Map<String, String>> translations;

  /// State for a [ScaffoldMessenger].
  ///
  /// You can declare a messenger key for your app that
  /// will be used by you or your package.
  final GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey;

  /// The main widget of your app, if you are not using a total routing system
  /// you can declare a home widget.
  final Widget? home;

  /// The routes of your app, you just declare them like normal app.
  final Map<String, WidgetBuilder>? routes;

  /// Starting route of your app, defaults to '/'.
  final String? initialRoute;
  final InitialRouteListFactory? onGenerateInitialRoutes;

  /// When we went to an route that is not registered this will work.
  final RouteFactory? onUnknownRoute;
  final RouteInformationProvider? routeInformationProvider;
  final RouteInformationParser<Object>? routeInformationParser;
  final RouterDelegate<Object>? routerDelegate;
  final BackButtonDispatcher? backButtonDispatcher;

  /// The builder of your app, you can use this for
  /// custom animations or other things that you want to do.
  final TransitionBuilder? builder;

  /// Default title of your app.
  final String title;

  /// This function is called whenever the app goes to a new screen and
  /// you can use it to generate new titles.
  ///
  /// Example
  /// ```dart
  /// onGenerateTitle: (context) {
  /// // dome some things
  /// return 'My Cool Title'; // your title will be this.
  /// }
  /// ```
  final GenerateAppTitle? onGenerateTitle;

  /// Your apps theme data.
  final ThemeData? theme;

  /// Your theme for [darkTheme] mode.
  final ThemeData? darkTheme;
  final ThemeData? highContrastTheme;
  final ThemeData? highContrastDarkTheme;

  /// The [themeMode] of your app.
  final ThemeMode? themeMode;

  /// Color that has general usage in your app.
  ///
  /// It may affect color in system depending on your device.
  final Color? color;

  /// Default locale that your app will use for [Okito] localizations.
  final Locale? locale;
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;
  final LocaleListResolutionCallback? localeListResolutionCallback;
  final LocaleResolutionCallback? localeResolutionCallback;

  /// List of supported locales.
  final Iterable<Locale> supportedLocales;
  final bool showPerformanceOverlay;
  final bool showSemanticsDebugger;
  final bool debugShowCheckedModeBanner;
  final Map<LogicalKeySet, Intent>? shortcuts;
  final Map<Type, Action<Intent>>? actions;
  final String? restorationScopeId;
  final bool debugShowMaterialGrid;
  final bool checkerboardRasterCacheImages;
  final bool checkerboardOffscreenLayers;

  @override
  Widget build(BuildContext ctx) {
    if (routes != null) Okito.app.routes = routes!;
    Okito.app.isMaterial = true;
    if (locale != null && Okito.app.locale == null) Okito.app.locale = locale;
    Okito.app.translations = translations;
    final navigatorKey = Okito.navigatorKey;
    final navigatorObservers = <NavigatorObserver>[OkitoObserver()];
    return Rockito<AppController>(
      (app) => routerDelegate == null
          ? MaterialApp(
              navigatorKey: navigatorKey,
              actions: actions,
              builder: (context, child) =>
                  builder == null ? child! : builder!(context, child),
              color: color,
              darkTheme: darkTheme,
              debugShowCheckedModeBanner: debugShowCheckedModeBanner,
              debugShowMaterialGrid: debugShowMaterialGrid,
              highContrastDarkTheme: highContrastDarkTheme,
              highContrastTheme: highContrastTheme,
              home: home,
              initialRoute: initialRoute,
              key: key,
              locale: app.locale,
              localeListResolutionCallback: localeListResolutionCallback,
              localeResolutionCallback: localeResolutionCallback,
              checkerboardOffscreenLayers: checkerboardOffscreenLayers,
              checkerboardRasterCacheImages: checkerboardRasterCacheImages,
              localizationsDelegates: localizationsDelegates,
              navigatorObservers: navigatorObservers,
              onGenerateInitialRoutes: onGenerateInitialRoutes,
              onGenerateRoute: Okito.app.onGenerateRoute,
              onGenerateTitle: onGenerateTitle,
              onUnknownRoute: onUnknownRoute,
              restorationScopeId: restorationScopeId,
              routes: Okito.app.routes,
              scaffoldMessengerKey: scaffoldMessengerKey,
              shortcuts: shortcuts,
              showPerformanceOverlay: showPerformanceOverlay,
              showSemanticsDebugger: showSemanticsDebugger,
              supportedLocales: supportedLocales,
              theme: app.themeData ?? theme,
              themeMode: app.themeMode ?? themeMode,
              title: title,
            )
          : MaterialApp.router(
              backButtonDispatcher: backButtonDispatcher,
              routeInformationProvider: routeInformationProvider,
              actions: actions,
              builder: (context, child) =>
                  builder == null ? child! : builder!(context, child),
              routerDelegate: routerDelegate!,
              routeInformationParser: routeInformationParser!,
              color: color,
              darkTheme: darkTheme,
              debugShowCheckedModeBanner: debugShowCheckedModeBanner,
              debugShowMaterialGrid: debugShowMaterialGrid,
              highContrastDarkTheme: highContrastDarkTheme,
              highContrastTheme: highContrastTheme,
              key: key,
              locale: app.locale,
              localeListResolutionCallback: localeListResolutionCallback,
              localeResolutionCallback: localeResolutionCallback,
              checkerboardOffscreenLayers: checkerboardOffscreenLayers,
              checkerboardRasterCacheImages: checkerboardRasterCacheImages,
              localizationsDelegates: localizationsDelegates,
              onGenerateTitle: onGenerateTitle,
              restorationScopeId: restorationScopeId,
              scaffoldMessengerKey: scaffoldMessengerKey,
              shortcuts: shortcuts,
              showPerformanceOverlay: showPerformanceOverlay,
              showSemanticsDebugger: showSemanticsDebugger,
              supportedLocales: supportedLocales,
              theme: app.themeData ?? theme,
              themeMode: app.themeMode ?? themeMode,
              title: title,
            ),
    );
  }
}
