import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'okito_utilities/okito_device.dart';
import 'okito_utilities/okito_routing.dart';
import 'okito_utilities/okito_widgets.dart';

/// The root of [Okito] library's utilities.
///
/// This class has shortcuts for routing, small utilities of context like
/// size of the device and has usage with widgets like show bottom modal sheet.
class Okito with OkitoWidgets, OkitoDevice, OkitoRouting {
  /// The context of your app.
  @override
  final BuildContext context;

  Okito(this.context);
  Okito.of(this.context);
}
