import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../okito.dart';
import '../utilities/constants.dart';

/// This is actually the most important mixin of [Okito] class. It handles
/// all the routing and it has the [navigatorKey] property.
///
/// We have to override [navigatorKey] because as you know, mixins can't be
/// instantiated.
mixin OkitoRouting {
  /// The [NavigatorState] of the app.
  /// You can use this to provide data to your material app.
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// Instead of writing [navigatorKey.currentState!] and doing a check, we
  /// check it here. Moreover, we throw custom exception to the developer to
  /// provide the [navigatorKey] or use
  /// one of [OkitoMaterialApp]-[OkitoCupertinoApp].
  NavigatorState? get _state {
    if (navigatorKey.currentState == null) {
      throw Exception(nullException);
    }
    return navigatorKey.currentState;
  }

  /// Equals to [Navigator.of(context).push()]
  /// Give it the [Route] you want to push
  ///
  /// Example
  /// ```dart
  /// Okito.push(MaterialPageRoute(builder: (context) => CounterPage()));
  /// ```
  Future<T?> push<T>(Route<T> route) async => _state?.push<T>(route);

  /// Similar to [Navigator.of(context).push()]
  /// Just give it the [page] you want to push
  ///
  /// Example
  /// ```dart
  /// // That Simple!
  /// Okito.pushEasy(CounterPage());
  /// ```
  Future<T?> pushEasy<T>(Widget page) async =>
      _state?.push<T>(Okito.app.isMaterial
          ? MaterialPageRoute(builder: (_) => page)
          : CupertinoPageRoute(builder: (_) => page));

  /// Equals to [Navigator.of(context).push()]
  /// Just give it the [routeName] you want to push
  ///
  /// Example
  /// ```dart
  /// // That Simple!
  /// Okito.pushNamed('/counterPage');
  /// // You can also add arguments as secondary parameter.
  /// ```
  ///
  /// Dynamic Routing:\
  /// In your [OkitoMaterialApp] or [OkitoCupertinoApp], you can add routes
  /// like ['/users/:id'] which will require a parameter, id.
  /// ```dart
  /// OkitoMaterialApp(routes: {
  ///      '/': (ctx) => FirstPage(),
  ///      '/users/:id': (_) => UsersPage(),
  ///    });
  /// ```
  ///
  /// Then you can push to that route
  /// ```dart
  /// Okito.pushNamed('/users/31');
  /// ```
  ///
  /// Lastly in your app
  /// ```dart
  /// Okito.parameters['id']; => 31
  /// ```
  Future<T?> pushNamed<T>(String routeName, {Object? arguments}) async {
    return _state?.pushNamed<T>(
      routeName,
      arguments: arguments,
    );
  }

  /// Equals to [Navigator.of(context).pushReplacement()]
  /// Just give it the [route] you want to push
  ///
  /// Example
  /// ```dart
  /// // That Simple!
  /// Okito.pushReplacement(
  ///    MaterialPageRoute(builder: (context) => CounterPage()));
  /// ```
  ///
  Future<T?> pushReplacement<T, X>(
    Route<T> route, {
    X? result,
  }) async =>
      _state?.pushReplacement<T, X>(route, result: result);

  /// Similar to [Navigator.of(context).pushReplacement()]
  /// Just give it the [page] you want to push
  ///
  /// Example
  /// ```dart
  /// // That Simple!
  /// Okito.pushReplacementEasy(CounterPage());
  /// ```
  Future<T?> pushReplacementEasy<T, X>(
    Widget page, {
    X? result,
  }) async =>
      _state?.pushReplacement<T, X>(
          Okito.app.isMaterial
              ? MaterialPageRoute(builder: (_) => page)
              : CupertinoPageRoute(builder: (_) => page),
          result: result);

  /// Equals to [Navigator.of(context).pushReplacementNamed()]
  /// Just give it the [routeName] you want to push
  ///
  /// Example
  /// ```dart
  /// // That Simple!
  /// Okito.pushReplacementNamed('/counterPage');
  /// // You can also add arguments as secondary parameter.
  /// ```
  ///
  /// Dynamic Routing:\
  /// In your [OkitoMaterialApp] or [OkitoCupertinoApp], you can add routes
  /// like ['/users/:id'] which will require a parameter, id.
  /// ```dart
  /// OkitoMaterialApp(routes: {
  ///      '/': (ctx) => FirstPage(),
  ///      '/users/:id': (_) => UsersPage(),
  ///    });
  /// ```
  ///
  /// Then you can push to that route
  /// ```dart
  /// Okito.pushReplacementNamed('/users/31');
  /// ```
  ///
  /// Lastly in your app
  /// ```dart
  /// Okito.parameters['id']; => 31
  /// ```
  Future<T?> pushReplacementNamed<T, X>(
    String routeName, {
    Object? arguments,
  }) async =>
      _state?.pushReplacementNamed<T, X>(
        routeName,
        arguments: arguments,
      );

  /// Equals to [Navigator.of(context).pushNamedAndRemoveUntil()]
  /// Just give it the [routeName] you want to push
  ///
  /// Example
  /// ```dart
  /// // That Simple!
  /// Okito.pushNamedAndRemoveUntil('/counterPage');
  /// // You can also add arguments as secondary parameter.
  /// ```
  ///  Not required but you can give it a [predicate]
  ///
  /// Dynamic Routing:\
  /// In your [OkitoMaterialApp] or [OkitoCupertinoApp], you can add routes
  /// like ['/users/:id'] which will require a parameter, id.
  /// ```dart
  /// OkitoMaterialApp(routes: {
  ///      '/': (ctx) => FirstPage(),
  ///      '/users/:id': (_) => UsersPage(),
  ///    });
  /// ```
  ///
  /// Then you can push to that route
  /// ```dart
  /// Okito.pushNamedAndRemoveUntil('/users/31');
  /// ```
  ///
  /// Lastly in your app
  /// ```dart
  /// Okito.parameters['id']; => 31
  /// ```
  Future<T?> pushNamedAndRemoveUntil<T>(
    String routeName, {
    Object? arguments,
    bool Function(Route<dynamic>)? predicate,
  }) async =>
      _state?.pushNamedAndRemoveUntil<T>(
        routeName,
        predicate ?? (_) => false,
        arguments: arguments,
      );

  /// Equals to [Navigator.of(context).pushAndRemoveUntil()]
  /// Just give it the [route] you want to push
  ///
  /// Example
  /// ```dart
  /// // That Simple!
  /// Okito.pushAndRemoveUntil(
  ///    MaterialPageRoute(builder: (context) => CounterPage()));
  /// ```
  ///  Not required but you can give it a [predicate]
  Future<T?> pushAndRemoveUntil<T>(
    Route<T> route, {
    bool Function(Route<dynamic>)? predicate,
  }) async =>
      _state?.pushAndRemoveUntil<T>(
        route,
        predicate ?? (_) => false,
      );

  /// Equals to [Navigator.of(context).pop()]
  ///
  /// Example
  /// ```dart
  /// // That Simple!
  /// Okito.pop();
  /// // You can also give it a result
  /// Okito.pop(result: 'Message sent successfully!');
  /// ```
  void pop<T>({T? result}) => _state?.pop<T>(result);

  /// Equals to [Navigator.of(context).canPop()]
  ///
  /// Example
  /// ```dart
  /// // That Simple!
  /// bool? canPop = Okito.canPop();
  /// ```
  bool? canPop() => _state?.canPop();

  /// Equals to [Navigator.of(context).maybePop()]
  Future<bool?> maybePop<T>([T? arguments]) async =>
      _state?.maybePop<T>(arguments);

  /// Equals to [Navigator.of(context).popUntil()]
  void popUntil(String route) => _state?.popUntil(ModalRoute.withName(route));
}
