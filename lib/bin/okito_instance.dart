import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'utilities/okito_utilities.dart';
import 'widgets/okito_widgets.dart';

class Okito with OkitoWidgets, OkitoUtilities {
  @override
  final BuildContext context;

  Okito(this.context);
  Okito.of(this.context);
}
