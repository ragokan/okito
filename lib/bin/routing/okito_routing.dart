import 'package:flutter/material.dart';
import '../extensions//okito_extensions.dart';

mixin OkitoRouting {
  late BuildContext context;

  void push({required Widget page, required RouteSettings settings}) =>
      context.push(page: page, settings: settings);

  void pushReplacement(
          {required Widget page, required RouteSettings settings}) =>
      context.pushReplacement(page: page, settings: settings);

  void pop({Object? result}) => context.pop(result: result);

  void pushNamed(
          {required String routeName,
          required RouteSettings settings,
          Object? arguments}) =>
      context.pushNamed(routeName: routeName, arguments: arguments);

  void pushReplacementNamed(
          {required String routeName,
          required RouteSettings settings,
          Object? arguments}) =>
      context.pushReplacementNamed(routeName: routeName, arguments: arguments);

  Object? get arguments => context.arguments;
  String? get routeName => context.routeName;
}
