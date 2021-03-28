import 'package:flutter/widgets.dart';

mixin OkitoUtilities {
  double width = 0;
  double height = 0;
  double aspectRatio = 0;

  void setUtilities(BuildContext context) {
    final size = MediaQuery.of(context).size;
    width = size.width;
    height = size.height;
    aspectRatio = size.aspectRatio;
  }
}
