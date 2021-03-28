import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'utilities/okito_utilities.dart';
import 'widgets/okito_widgets.dart';

class _Okito with OkitoUtilities, OkitoWidgets {
  BuildContext? _context;

  @override
  BuildContext get context =>
      _context ?? GlobalKey<NavigatorState>().currentContext!;

  @override
  set context(BuildContext? context) => _context = context;
}

// To implement in future
// ignore: non_constant_identifier_names
final _Okito Okito = _Okito();
