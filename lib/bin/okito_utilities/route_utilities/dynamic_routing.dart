import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../okito.dart';

extension on String {
// TODO: Add Document
  List<String> get parse {
    var wantedPathName = this;
    if (wantedPathName.startsWith('/')) {
      wantedPathName = wantedPathName.substring(1);
    }

    var parts = wantedPathName.split('/');
    return parts;
  }
}

// TODO: Add Document
extension on List<String> {
  List<String> get whereStartsWithAlphabet =>
      where((element) => element.toLowerCase().startsWith(RegExp(r'[a-z]')))
          .toList();
}

// TODO: Add Document
bool compareRoute(String wantedPathName, String route) {
  var listRoute = route.parse.whereStartsWithAlphabet;
  var listPath = wantedPathName.parse.whereStartsWithAlphabet;
  var isOk = true;

  for (var route in listRoute) {
    if (isOk) isOk = listPath.contains(route);
  }

  return isOk;
}

// TODO: Add Document
Map<String, dynamic> getArgumentsFromRoute(
    String wantedPathName, String route) {
  try {
    var routeList = route.parse;
    var wantedPathNameList = wantedPathName.parse;

    routeList.removeWhere((element) => wantedPathName.parse.contains(element));
    wantedPathNameList.removeWhere((element) => route.parse.contains(element));
    routeList = routeList.map((element) => element.substring(1)).toList();

    var arguments = <String, dynamic>{};

    for (var i = 0; i < routeList.length; i++) {
      arguments[routeList[i]] = wantedPathNameList[i];
    }

    return arguments;
    // ignore: avoid_catches_without_on_clauses
  } catch (_) {
    return {};
  }
}

// TODO: Add Document
Route<dynamic>? pageRouteBuilder(RouteSettings settings) {
  Widget Function(BuildContext)? targetPage;
  String? parsedString;

  void setRoute(route, value) {
    targetPage = value;
    parsedString = route;
  }

  Okito.app.routes.forEach((route, value) =>
      (compareRoute(settings.name!, route)) ? setRoute(route, value) : null);

  if (targetPage != null) {
    return Okito.app.isMaterial
        ? MaterialPageRoute(
            fullscreenDialog: false,
            maintainState: true,
            settings: RouteSettings(
                name: settings.name,
                arguments:
                    getArgumentsFromRoute(settings.name ?? '', parsedString!)),
            builder: (
              context,
            ) =>
                targetPage!(context),
          )
        : CupertinoPageRoute(
            fullscreenDialog: false,
            maintainState: true,
            settings: RouteSettings(
                name: settings.name,
                arguments:
                    getArgumentsFromRoute(settings.name ?? '', parsedString!)),
            builder: (
              context,
            ) =>
                targetPage!(context),
          );
  }
}

// TODO: Add Document
RouteSettings generateSettings({required String name, Object? arguments}) =>
    RouteSettings(name: name, arguments: arguments);
