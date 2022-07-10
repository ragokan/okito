// ignore_for_file: avoid_renaming_method_parameters

import 'package:flutter/material.dart';

import '../../okito.dart';
import '../../public_types/main.dart';

// TODO: Add documents here.

/// [OkitoMaterialApp] is the replacement of [MaterialApp] to use
/// all of [Okito] features in your app!
class OkitoMaterialApp extends StatelessWidget {
  /// The constant constuctor of [OkitoMaterialApp].
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
    this.navigatorObservers,
  }) : super(key: key);

  /// Use this only if you are using another library that requires
  /// navigatorObservers. You don't need to do this for Okito.
  final List<NavigatorObserver>? navigatorObservers;

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
  final TranslationMapType translations;

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

  /// This function is called at the start of app, when it generates
  /// the routes.
  final InitialRouteListFactory? onGenerateInitialRoutes;

  /// When we went to an route that is not registered this will work.
  final RouteFactory? onUnknownRoute;

  /// A route information provider that provides route information
  /// for the [Router] widget.
  final RouteInformationProvider? routeInformationProvider;

  /// A delegate that is used by the [Router] widget to parse a route
  ///  information into a configuration of type T.
  final RouteInformationParser<Object>? routeInformationParser;

  /// A delegate that is used by the [Router] widget to build and
  ///  configure a navigating widget.
  final RouterDelegate<Object>? routerDelegate;

  /// Report to a [Router] when the user taps the back button on
  /// platforms that support back buttons like Android.
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

  /// High constrast theme for your app.
  final ThemeData? highContrastTheme;

  /// High constrast dark theme for your app.
  final ThemeData? highContrastDarkTheme;

  /// The [themeMode] of your app.
  final ThemeMode? themeMode;

  /// Color that has general usage in your app.
  ///
  /// It may affect color in system depending on your device.
  final Color? color;

  /// Default locale that your app will use for [Okito] localizations.
  final Locale? locale;

  /// The delegates for this app's [Localizations] widget.
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;

  /// This callback is responsible for choosing the app's locale when the app
  /// is started, and when the user changes the device's locale.
  final LocaleListResolutionCallback? localeListResolutionCallback;

  /// The signature of [WidgetsApp.localeResolutionCallback].
  final LocaleResolutionCallback? localeResolutionCallback;

  /// List of supported locales.
  final Iterable<Locale> supportedLocales;

  /// Turns on a performance overlay.
  final bool showPerformanceOverlay;

  /// Turns on checkerboarding of raster cache images.
  final bool checkerboardRasterCacheImages;

  /// Turns on checkerboarding of layers rendered to offscreen bitmaps.
  final bool checkerboardOffscreenLayers;

  /// Turns on an overlay that shows the accessibility information
  ///  reported by the framework.
  final bool showSemanticsDebugger;

  /// Turns on a little "DEBUG" banner in checked mode to indicate
  ///  that the app is in checked mode.
  final bool debugShowCheckedModeBanner;

  /// The default map of intent keys to actions for the application.
  final Map<Type, Action<Intent>>? actions;

  /// The identifier to use for state restoration of this app.
  final String? restorationScopeId;

  /// The default map of keyboard shortcuts to intents for the application.
  final Map<LogicalKeySet, Intent>? shortcuts;

  /// Turns on a [GridPaper] overlay that paints a baseline grid Material apps.
  final bool debugShowMaterialGrid;

  @override
  Widget build(BuildContext ctx) {
    if (routes != null) Okito.app.routes = routes!;
    Okito.app.isMaterial = true;
    if (locale != null && Okito.app.locale == null) Okito.app.locale = locale;
    Okito.app.translations = translations;
    final navigatorKey = Okito.navigatorKey;
    final localNavigatorObservers = navigatorObservers == null
        ? <NavigatorObserver>[OkitoObserver()]
        : <NavigatorObserver>[OkitoObserver(), ...navigatorObservers!];
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
              navigatorObservers: localNavigatorObservers,
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
