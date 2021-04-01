import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'okito_utilities/okito_device.dart';
import 'okito_utilities/okito_routing.dart';
import 'okito_utilities/okito_widgets.dart';

/// The root of [Okito] library's utilities.
///
/// This class has shortcuts for routing, small utilities of context like
/// size of the device and has usage with widgets like show bottom modal sheet.
class _Okito with OkitoWidgets, OkitoDevice, OkitoRouting {
  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// The [BuildContext]:[context] of your app.
  @override
  BuildContext? get context {
    if (navigatorKey.currentContext == null) {
      throw Exception('''
      If you want to use [context] in your app just like this, you have to
      use one of these; 
      1) [OkitoMaterialApp] instead of MaterialApp,
      2) [OkitoCupertinoApp] instead of CupertinoApp,
      3) Add these to your Material/Cupertino App;
        - navigatorKey: Okito.navigatorKey,
        - navigatorObservers: [Okito.navigatorObserver].
        
      If you did and still got an error, please create a github issue.
    ''');
    }
    return navigatorKey.currentContext;
  }
}

// ignore: non_constant_identifier_names
_Okito Okito = _Okito();
