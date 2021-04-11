import 'package:flutter/material.dart';

/// The extensions for [BuildContext] that helps in development.
extension BuildContextExtensions on BuildContext {
  /// The horizontal extent of this size.
  double get width => MediaQuery.of(this).size.width;

  /// The vertical extent of this size.
  double get height => MediaQuery.of(this).size.height;

  /// The aspect ratio of this size.
  ///
  ///This returns the [width] divided by the [height].
  double get aspectRatio => MediaQuery.of(this).size.aspectRatio;

  /// The number of device pixels for each logical pixel. This number might not
  ///  be a power of two. Indeed, it might not even be an integer. For example,
  ///  the Nexus 6 has a device pixel ratio of 3.5.
  double get devicePixelRatio => MediaQuery.of(this).devicePixelRatio;

  /// Whether device is wider than tall or not.
  bool get isLandscape =>
      MediaQuery.of(this).orientation == Orientation.landscape;

  /// Whether device is taller than wide or not.
  bool get isPortrait =>
      MediaQuery.of(this).orientation == Orientation.portrait;

  /// App theme.
  ThemeData get theme => Theme.of(this);

  /// Arguments of current context.
  Object? get arguments => ModalRoute.of(this)?.settings.arguments;

  /// Name of current route.
  String? get routeName => ModalRoute.of(this)?.settings.name;
}
