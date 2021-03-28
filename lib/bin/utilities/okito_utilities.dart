import 'package:flutter/material.dart';
import '../extensions//okito_extensions.dart';

mixin OkitoUtilities {
  late BuildContext context;
  double get width => context.width;
  double get height => context.height;
  double get aspectRatio => context.aspectRatio;
  bool get isLandscape => context.isLandscape;
  bool get isPortrait => context.isPortrait;
  ThemeData get theme => Theme.of(context);
  double get devicePixelRatio => context.devicePixelRatio;
}
