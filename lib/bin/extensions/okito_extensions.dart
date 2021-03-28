import 'package:flutter/cupertino.dart';
import '../../okito.dart';

extension Utilities on BuildContext {
  double get width => Okito.of(this).width;
  double get height => Okito.of(this).height;
  double get aspectRatio => Okito.of(this).aspectRatio;
  bool get isLandscape => Okito.of(this).isLandscape;
  bool get isPortrait => Okito.of(this).isPortrait;
}
