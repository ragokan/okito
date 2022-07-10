import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../okito.dart';

/// This is an private extension to use parsing function only.
extension on String {
  /// Parses the string and returns a list of string.
  /// At parse, we just [split] the values with ['/']
  ///
  /// Example
  ///
  /// ```dart
  /// '/users/31' => [users, 31]
  /// '/users/:id' => [users, :id]
  /// ```
  List<String> get parse {
    var wantedPathName = this;
    if (wantedPathName.startsWith('/')) {
      wantedPathName = wantedPathName.substring(1);
    }

    var parts = wantedPathName.split('/');
    return parts;
  }
}

/// Again, it is also a private extension created not to do code repeating.
extension on List<String> {
  /// This is used for [_compareRoute] function that is declared below.
  ///
  /// It gets a list of strings and returns the ones starts with alphabet.
  ///
  /// Example
  ///
  /// ```dart
  /// '/users/home/31' => [users,home]
  /// '/users/home/:id' => [users,home]
  /// ```
  List<String> get whereStartsWithAlphabet =>
      where((element) => element.toLowerCase().startsWith(RegExp(r'[a-z]')))
          .toList();
}

/// Compares two routes using [List<String>.whereStartsWithAlphabet] method.
bool _compareRoute(String wantedPathName, String route) {
  var listRoute = route.parse.whereStartsWithAlphabet;
  var listPath = wantedPathName.parse.whereStartsWithAlphabet;

  /// Initially [isOk] is true.
  var isOk = true;

  for (var route in listRoute) {
    /// If the [listPath] such as [users,home] doesn't contain one of the values
    /// of [listRoute], [isOk] will became false, so the loop will return false.
    ///
    /// As a result, we can understand that routes are not same.
    if (isOk) isOk = listPath.contains(route);
  }

  return isOk;
}

/// Converts a dynamic url to map for params.
/// Example values of [route] = ['/users/:id']
/// Example values of [wantedPathName] = ['/users/31']
///
/// Here we will first parse the string by ['/'], it will give us this;
///
/// [route] = [users,:id]
/// [wantedPathName] = [users,31]
///
/// Then we will remove the [:] at the beginning of [id] and create a map
/// with arguments
/// [{id:31}], amazing, right?
Map<String, dynamic> _getArgumentsFromRoute(
    String wantedPathName, String route) {
  try {
    /// Firstly, we do [parse] the [route] and [wantedPathName]
    var routeList = route.parse;
    var wantedPathNameList = wantedPathName.parse;

    /// these bottom removes the equalities in array, for example
    /// if both of them have [users], we directly remove it.
    ///
    /// As result we will get [:id] and [31]
    routeList.removeWhere((element) => wantedPathName.parse.contains(element));
    wantedPathNameList.removeWhere((element) => route.parse.contains(element));

    /// Then we remove the [:] at the beginning of [:id] and it gives us [id]
    routeList = routeList.map((element) => element.substring(1)).toList();

    var arguments = <String, dynamic>{};

    /// Lastly we just simple do this :
    /// [id] : [31]
    for (var i = 0; i < routeList.length; i++) {
      arguments[routeList[i]] = wantedPathNameList[i];
    }

    return arguments;

    /// Why we do a [catch]?
    /// It is because user may made some mistakes on path or when
    /// we do try to parse a value it may give error.
    ///
    /// In that case we will return arguments as just an empty map
    /// instead of giving error.
    // ignore: avoid_catches_without_on_clauses
  } catch (_) {
    return {};
  }
}

/// [pageRouteBuilder] is the way to create a route
/// from [RouteSettings]:[settings] which contains only [RouteSettings.name]
/// and [RouteSettings.arguments].
///
/// For the process, you can keep reading the source code, I added documents
/// everywhere I can add.
Route<dynamic>? pageRouteBuilder(RouteSettings settings) {
  /// Firstly we should have a target page to push.
  Widget Function(BuildContext)? targetPage;

  /// Secondly we do need a parsedString, empty at start.
  var parsedString = '';

  /// We will check all of [Okito.app.routes] which are the [route] list
  /// that is defined at [OkitoMaterialApp] or [OkitoCupertinoApp].
  ///
  /// Then, we simply call this method to set
  /// both [targetPage] and [parsedString]
  void setRoute(route, value) {
    targetPage = value;
    parsedString = route;
  }

  /// We check the apps routes whether there are a route named like target
  /// route or not.
  Okito.app.routes.forEach((route, value) =>
      (_compareRoute(settings.name!, route)) ? setRoute(route, value) : null);

  if (targetPage != null) {
    /// Here we give the name to show in browser
    /// Arguments are also coming from route.

    var argumentsFromRoute =
        _getArgumentsFromRoute(Uri.parse(settings.name!).path, parsedString);

    final stringQuery = Uri.parse(settings.name!).hasQuery
        ? Uri.parse(settings.name!).query
        : null;

    if (stringQuery != null) {
      final listQuery = stringQuery.split(RegExp(r'[?&]'));
      for (var element in listQuery) {
        final queryElement = element.split('=');
        argumentsFromRoute.addAll({queryElement[0]: queryElement[1]});
      }
    }

    /// If the user provided arguments, we pass it here.
    if (settings.arguments != null) {
      argumentsFromRoute.addAll({'arguments': settings.arguments});
    }

    var routeSettings =
        RouteSettings(name: settings.name!, arguments: argumentsFromRoute);

    /// We check if the app is MaterialApp or not.
    /// If material, we show material animations, if cupertino
    /// we show cupertino animations.
    return Okito.app.isMaterial
        ? MaterialPageRoute(
            fullscreenDialog: false,
            maintainState: true,
            settings: routeSettings,
            builder: (
              context,
            ) =>
                targetPage!(context))
        : CupertinoPageRoute(
            fullscreenDialog: false,
            maintainState: true,
            settings: routeSettings,
            builder: (
              context,
            ) =>
                targetPage!(context));
  } else {
    /// The route user wanted may not be registered to the app,
    /// in that case we will try to push to /notFound, if that exists.
    if (Okito.app.routes.containsKey('/notFound')) {
      Okito.pushNamed('/notFound');
    }
    return null;
  }
}
