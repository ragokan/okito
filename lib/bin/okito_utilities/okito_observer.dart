import 'package:flutter/material.dart';
import '../../okito.dart';

class OkitoObserver extends NavigatorObserver {
  void _setVariables(Route? newRoute) {
    Okito.currentRoute = newRoute?.settings.name;
    Okito.arguments = newRoute?.settings.arguments;
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
