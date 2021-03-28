import 'package:flutter/cupertino.dart';

extension Utilities on BuildContext {
  double get width => MediaQuery.of(this).size.width;
}
