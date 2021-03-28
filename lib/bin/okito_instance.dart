import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'routing/okito_routing.dart';
import 'utilities/okito_utilities.dart';
import 'widgets/okito_widgets.dart';

class Okito with OkitoWidgets, OkitoUtilities, OkitoRouting {
  @override
  final BuildContext context;

  Okito(this.context);
  Okito.of(this.context);
}
