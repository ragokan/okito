import 'package:flutter/material.dart';

import '../../okito.dart';
import '../typedefs/callback_types.dart';
import 'builder_lite.dart';

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
  ControllerCallback<T> callback,
) {
  /// We get the controller here with dependency injection and provide it.
  final _controller = Okito.use<T>();
  return OkitoBuilderLite(
    controller: _controller,
    builder: () => callback(_controller),
  );
}
