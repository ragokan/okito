import 'package:flutter/material.dart';

import '../../okito.dart';
import '../../typedefs/callback_types.dart';

/// The [Rockito] and other Rockitos are the way to use builders
/// with [Okito.inject()].
///
/// ```dart
/// // Usage is very simple as usual, actually the simplest.
/// Rockito<CounterController>(
///    (controller) => Text('${controller.count}'),
///   );
///
/// ```
// ignore: non_constant_identifier_names
Widget Rockito<T extends OkitoController>(
  RockitoCallback<T> builder,
) {
  final controller = Okito.take<T>();
  return OkitoBuilder(
    controller: controller,
    builder: () => builder(controller),
  );
}
