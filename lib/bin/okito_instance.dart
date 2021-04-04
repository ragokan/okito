import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../okito.dart';

import '../utilities/constants.dart';
import 'okito_utilities/index.dart';

class _Okito
    with
        OkitoWidgets,
        OkitoDevice,
        OkitoRouting,
        OkitoDependencyInjection,
        OkitoFunctions {
  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// The [BuildContext]:[context] of your app.
  @override
  BuildContext? get context {
    if (navigatorKey.currentContext == null) {
      throw Exception(nullException);
    }
    return navigatorKey.currentContext;
  }

  String? routeName;
  Object? arguments;

  AppController get app => use<AppController>();
}

/// The root of [Okito] library's utilities.
///
/// This class has shortcuts for routing, small utilities of context like
/// size of the device and has usage with widgets like show bottom modal sheet.
// ignore: non_constant_identifier_names
final _Okito Okito = _Okito();
