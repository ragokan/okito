import 'package:flutter/material.dart';
import '../extensions/context_extensions.dart';

mixin OkitoRouting {
  late BuildContext context;

  /// Push the given route onto the navigator that most
  /// tightly encloses the given context.
  void push({required Widget page, required RouteSettings settings}) =>
      context.push(page: page, settings: settings);

  /// Replace the current route of the navigator that most tightly encloses the
  ///  given context by pushing the given route and then disposing the previous
  ///  route once the new route has finished animating in.
  void pushReplacement(
          {required Widget page, required RouteSettings settings}) =>
      context.pushReplacement(page: page, settings: settings);

  /// Pop the top-most route off the navigator that
  ///  most tightly encloses the given context.
  void pop({Object? result}) => context.pop(result: result);

  /// Push a named route onto the navigator that most
  ///  tightly encloses the given context.
  void pushNamed(
          {required String routeName,
          RouteSettings? settings,
          Object? arguments}) =>
      context.pushNamed(routeName: routeName, arguments: arguments);

  /// Replace the current route of the navigator that most tightly encloses
  ///  the given context by pushing the route named [routeName] and then
  ///  disposing the previous route once the new route has finished
  /// animating in.
  void pushReplacementNamed({required String routeName, Object? arguments}) =>
      context.pushReplacementNamed(routeName: routeName, arguments: arguments);

  /// The arguments passed to this route.
  Object? get arguments => context.arguments;

  /// The name of the route (e.g., "/settings").
  String? get routeName => context.routeName;
}
