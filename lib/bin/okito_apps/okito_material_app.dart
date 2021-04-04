import 'package:flutter/material.dart';

import '../../okito.dart';
import '../okito_instance.dart';
import '../okito_utilities/okito_observer.dart';
import 'app_controller.dart';

/// [OkitoMaterialApp] is the replacement of [MaterialApp] to use
/// all of [Okito] features in your app!
class OkitoMaterialApp extends StatelessWidget {
  const OkitoMaterialApp(
      {Key? key,
      this.scaffoldMessengerKey,
      this.home,
      Map<String, WidgetBuilder> this.routes = const <String, WidgetBuilder>{},
      this.initialRoute,
      this.onGenerateRoute,
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
      this.checkerboardOffscreenLayers = false});

  final GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey;
  final Widget? home;
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
  final ThemeData? theme;
  final ThemeData? darkTheme;
  final ThemeData? highContrastTheme;
  final ThemeData? highContrastDarkTheme;
  final ThemeMode? themeMode;
  final Color? color;
  final Locale? locale;
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;
  final LocaleListResolutionCallback? localeListResolutionCallback;
  final LocaleResolutionCallback? localeResolutionCallback;
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
    final navigatorKey = Okito.navigatorKey;
    final navigatorObservers = <NavigatorObserver>[OkitoObserver()];
    return RockitoBuilder<AppController>(
      inject: AppController(),
      builder: (app) => routerDelegate == null
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
              restorationScopeId: restorationScopeId,
              routes: routes ?? const <String, WidgetBuilder>{},
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
              locale: app.locale ?? locale,
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
