import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../okito.dart';
import '../okito_instance.dart';
import '../okito_utilities/okito_observer.dart';
import 'app_controller.dart';

// TODO: Add documents here.

/// [OkitoCupertinoApp] is the replacement of [CupertinoApp] to use
/// all of [Okito] features in your app!
class OkitoCupertinoApp extends StatelessWidget {
  /// The constant constuctor of [OkitoCupertinoApp].
  const OkitoCupertinoApp({
    Key? key,
    this.home,
    this.theme,
    this.routes,
    this.initialRoute,
    this.onGenerateInitialRoutes,
    this.onUnknownRoute,
    this.routeInformationProvider,
    this.routeInformationParser,
    this.routerDelegate,
    this.backButtonDispatcher,
    this.builder,
    this.title = 'OkitoCupertinoApp',
    this.onGenerateTitle,
    this.color,
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.showPerformanceOverlay = false,
    this.checkerboardRasterCacheImages = false,
    this.checkerboardOffscreenLayers = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = true,
    this.actions,
    this.restorationScopeId,
    this.shortcuts,
    this.translations = const {},
  }) : super(key: key);

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

  /// The main widget of your app, if you are not using a total routing system
  /// you can declare a home widget.
  final Widget? home;

  /// Your apps theme data.
  final CupertinoThemeData? theme;

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

  @override
  Widget build(BuildContext ctx) {
    if (routes != null) Okito.app.routes = routes!;
    Okito.app.isMaterial = false;
    if (locale != null && Okito.app.locale == null) Okito.app.locale = locale;
    Okito.app.translations = translations;

    final navigatorKey = Okito.navigatorKey;
    final navigatorObservers = <NavigatorObserver>[OkitoObserver()];
    return Rockito<AppController>((app) => routerDelegate == null
        ? CupertinoApp(
            restorationScopeId: restorationScopeId,
            shortcuts: shortcuts,
            theme: app.cupertinoThemeData,
            navigatorKey: navigatorKey,
            actions: actions,
            builder: (context, child) =>
                builder == null ? child! : builder!(context, child),
            color: color,
            debugShowCheckedModeBanner: debugShowCheckedModeBanner,
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
            routes: Okito.app.routes,
            showPerformanceOverlay: showPerformanceOverlay,
            showSemanticsDebugger: showSemanticsDebugger,
            supportedLocales: supportedLocales,
            title: title,
          )
        : CupertinoApp.router(
            shortcuts: shortcuts,
            restorationScopeId: restorationScopeId,
            backButtonDispatcher: backButtonDispatcher,
            routeInformationProvider: routeInformationProvider,
            theme: app.cupertinoThemeData,
            actions: actions,
            builder: (context, child) =>
                builder == null ? child! : builder!(context, child),
            routerDelegate: routerDelegate!,
            routeInformationParser: routeInformationParser!,
            color: color,
            debugShowCheckedModeBanner: debugShowCheckedModeBanner,
            key: key,
            locale: app.locale,
            localeListResolutionCallback: localeListResolutionCallback,
            localeResolutionCallback: localeResolutionCallback,
            checkerboardOffscreenLayers: checkerboardOffscreenLayers,
            checkerboardRasterCacheImages: checkerboardRasterCacheImages,
            localizationsDelegates: localizationsDelegates,
            onGenerateTitle: onGenerateTitle,
            showPerformanceOverlay: showPerformanceOverlay,
            showSemanticsDebugger: showSemanticsDebugger,
            supportedLocales: supportedLocales,
            title: title,
          ));
  }
}
