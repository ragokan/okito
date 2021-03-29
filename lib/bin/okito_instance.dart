import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'routing/okito_routing.dart';
import 'utilities/okito_utilities.dart';
import 'widgets/okito_widgets.dart';

/// The root of [Okito] library's utilities.
///
/// This class has shortcuts for routing, small utilities of context like
/// size of the device and has usage with widgets like show bottom modal sheet.
class Okito with OkitoWidgets, OkitoUtilities, OkitoRouting {
  /// The context of your app.
  @override
  final BuildContext context;

  Okito(this.context);
  Okito.of(this.context);
}
