import 'package:flutter/widgets.dart';

mixin OkitoUtilities {
  BuildContext? context;
  double get width => MediaQuery.of(context!).size.width;
  double get height => MediaQuery.of(context!).size.height;
  double get aspectRatio => MediaQuery.of(context!).size.aspectRatio;

  bool get isLandscape =>
      MediaQuery.of(context!).orientation == Orientation.landscape;
  bool get isPortrait =>
      MediaQuery.of(context!).orientation == Orientation.portrait;
}
