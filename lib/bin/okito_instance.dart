import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'utilities/okito_utilities.dart';

class _Okito with OkitoUtilities {
  GlobalKey<NavigatorState>? key = GlobalKey<NavigatorState>();

  BuildContext? context;
}

// To implement in future
// ignore: non_constant_identifier_names
final _Okito Okito = _Okito();
