import 'package:flutter/material.dart';
import '../../okito.dart';

/// For this file, I don't think that it is necessary to add
/// documents for each function, so I will describe them here.
///
/// This page is important to set the arguments of routes when
/// the page changes.
///
/// We do set two variables here, [Okito.arguments!] and [Okito.routeName!]

/// Observer is the way to observe navigation in [Okito]
class OkitoObserver extends NavigatorObserver {
  void _setVariables(Route? newRoute) {
    Okito.routeName = newRoute?.settings.name ?? Okito.context?.routeName;

    /// Firstly, we do check that if we do have arguments from the
    /// dynamic routing like [id] : [31]
    ///
    /// If it exists, we set arguments as [Map<String,dynamic>]
    ///
    /// else we get the arguments and create our arguments map.
    if (newRoute?.settings.arguments.runtimeType.toString().contains('Map') ==
        true) {
      Okito.arguments = newRoute?.settings.arguments as Map<String, dynamic>;
    } else {
      Okito.arguments = {'arguments': newRoute?.settings.arguments};
    }
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    _setVariables(route);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    _setVariables(previousRoute ?? route);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);
    _setVariables(previousRoute ?? route);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    _setVariables(newRoute);
  }
}
