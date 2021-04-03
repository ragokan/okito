import 'package:flutter/material.dart';
import '../../okito.dart';

/// Observer is the way
class OkitoObserver extends NavigatorObserver {
  void _setVariables(Route? newRoute) {
    Okito.routeName = newRoute?.settings.name ?? Okito.context?.routeName;
    Okito.arguments = newRoute?.settings.arguments ?? Okito.context?.arguments;
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
