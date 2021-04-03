import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../okito_instance.dart';
import '../okito_utilities/okito_observer.dart';

/// [OkitoCupertinoApp] is the replacement of [CupertinoApp] to use
/// all of [Okito] features in your app!
class OkitoCupertinoApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = Okito.navigatorKey;
  final List<NavigatorObserver> navigatorObservers = <NavigatorObserver>[
    OkitoObserver()
  ];

  final Widget? home;
  final CupertinoThemeData? theme;
  final Map<String, WidgetBuilder>? routes;
  final String? initialRoute;
  final RouteFactory? onGenerateRoute;
  final InitialRouteListFactory? onGenerateInitialRoutes;
  final RouteFactory? onUnknownRoute;
  final RouteInformationProvider? routeInformationProvider;
  final RouteInformationParser<Object>? routeInformationParser;
  final RouterDelegate<Object>? routerDelegate;
  final BackButtonDispatcher? backButtonDispatcher;
  final TransitionBuilder? builder;
  final String title;
  final GenerateAppTitle? onGenerateTitle;
  final Color? color;
  final Locale? locale;
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;
  final LocaleListResolutionCallback? localeListResolutionCallback;
  final LocaleResolutionCallback? localeResolutionCallback;
  final Iterable<Locale> supportedLocales;
  final bool showPerformanceOverlay;
  final bool checkerboardRasterCacheImages;
  final bool checkerboardOffscreenLayers;
  final bool showSemanticsDebugger;
  final bool debugShowCheckedModeBanner;
  final Map<Type, Action<Intent>>? actions;
  OkitoCupertinoApp({
    Key? key,
    this.home,
    this.theme,
    this.routes,
    this.initialRoute,
    this.onGenerateRoute,
    this.onGenerateInitialRoutes,
    this.onUnknownRoute,
    this.routeInformationProvider,
    this.routeInformationParser,
    this.routerDelegate,
    this.backButtonDispatcher,
    this.builder,
    required this.title,
    this.onGenerateTitle,
    this.color,
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    required this.supportedLocales,
    required this.showPerformanceOverlay,
    required this.checkerboardRasterCacheImages,
    required this.checkerboardOffscreenLayers,
    required this.showSemanticsDebugger,
    required this.debugShowCheckedModeBanner,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext ctx) {
    return routerDelegate == null
        ? CupertinoApp(
            theme: theme,
            navigatorKey: navigatorKey,
            actions: actions,
            builder: (context, child) =>
                builder == null ? child! : builder!(context, child),
            color: color,
            debugShowCheckedModeBanner: debugShowCheckedModeBanner,
            home: home,
            initialRoute: initialRoute,
            key: key,
            locale: locale,
            localeListResolutionCallback: localeListResolutionCallback,
            localeResolutionCallback: localeResolutionCallback,
            checkerboardOffscreenLayers: checkerboardOffscreenLayers,
            checkerboardRasterCacheImages: checkerboardRasterCacheImages,
            localizationsDelegates: localizationsDelegates,
            navigatorObservers: navigatorObservers,
            onGenerateInitialRoutes: onGenerateInitialRoutes,
            onGenerateRoute: onGenerateRoute,
            onGenerateTitle: onGenerateTitle,
            onUnknownRoute: onUnknownRoute,
            routes: routes ?? const <String, WidgetBuilder>{},
            showPerformanceOverlay: showPerformanceOverlay,
            showSemanticsDebugger: showSemanticsDebugger,
            supportedLocales: supportedLocales,
            title: title,
          )
        : CupertinoApp.router(
            theme: theme,
            actions: actions,
            builder: (context, child) =>
                builder == null ? child! : builder!(context, child),
            routerDelegate: routerDelegate!,
            routeInformationParser: routeInformationParser!,
            color: color,
            debugShowCheckedModeBanner: debugShowCheckedModeBanner,
            key: key,
            locale: locale,
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
          );
  }
}
