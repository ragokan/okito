import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../okito.dart';
import 'utilities/constants.dart';

/// The implementation of [Okito].
///
/// We use it as a private class because it is not optimal to have multiple
/// Okito classes.
class _Okito
    with
        OkitoWidgets,
        OkitoDevice,
        OkitoRouting,
        OkitoDependencyInjection,
        OkitoFunctions {
  @override

  /// The [BuildContext]:[context] of your app.
  /// If you don't use [OkitoMaterialApp]-[OkitoCupertinoApp] or
  /// provide [navigatorKey] to the your app, it will throw an exception.
  @override
  BuildContext? get context {
    if (navigatorKey.currentContext == null) {
      throw Exception(nullException);
    }
    return navigatorKey.currentContext;
  }

  /// Current route name
  /// For example: '/users/okito/31'
  String? routeName;

  /// Arguments of your current route.
  /// It will always be a Map.
  ///
  /// When you go to a new route and for example do this:
  /// ```dart
  /// Okito.pushNamed('/users',arguments:22)
  ///
  /// // The result will be:
  /// Okito.arguments = {'arguments': 22};
  ///
  /// // So, to use it
  /// final id = Okito.arguments['arguments'] as int;
  ///
  /// // The reason of doing it is dynamic routing.
  /// ```
  Map<String, dynamic> arguments = {};

  /// The root controller of your [OkitoMaterialApp] or [OkitoCupertinoApp].
  ///
  /// If you want, you can use this expression to use, too.
  ///
  /// ```dart
  /// Okito.use<AppController>(); // this is same as Okito.app;
  /// ```
  ///
  /// This controller is responsible for your app, you can use it to do
  /// almost anything with your app, even updating the whole app with
  /// update command.
  AppController get app => use<AppController>();

  _Okito() {
    /// We inject the [AppController] here, if the user doesn't use
    /// either of [OkitoMaterialApp] or [OkitoCupertinoApp], the features
    /// won't work.
    inject(AppController());
  }
}

/// The root of [Okito] library's utilities.
///
/// This class has shortcuts for routing, small utilities of context like
/// size of the device and has usage with widgets like show bottom modal sheet.
// ignore: non_constant_identifier_names
final _Okito Okito = _Okito();
