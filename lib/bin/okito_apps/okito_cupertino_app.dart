import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../okito.dart';
import '../okito_instance.dart';
import '../okito_utilities/okito_observer.dart';
import 'app_controller.dart';

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
  final String? restorationScopeId;
  final Map<LogicalKeySet, Intent>? shortcuts;
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
  }) : super(key: key);

  @override
  Widget build(BuildContext ctx) => RockitoBuilder<AppController>(
      inject: AppController(),
      builder: (app) => routerDelegate == null
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
              locale: app.locale ?? locale,
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
              locale: app.locale ?? locale,
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
