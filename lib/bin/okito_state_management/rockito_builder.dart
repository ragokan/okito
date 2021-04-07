import 'package:flutter/material.dart';

import '../../okito.dart';
import '../../typedefs/callback_types.dart';

/// The [RockitoBuilder] and other Rockitos are the way to use builders
/// with [Okito.inject()].
///
/// ```dart
/// // Usage is very simple as usual.
/// RockitoBuilder<CounterController>(
///     builder: (controller) => Text('${controller.count}'),
///   );
///
/// // If you didn't inject controller yet;
/// RockitoBuilder<CounterController>(
///     inject: CounterController(), // Required only one and first time
///     builder: (controller) => Text('${controller.count}'),
///   );
/// ```
// ignore: non_constant_identifier_names
Widget RockitoBuilder<T extends OkitoController>({
  required RockitoCallback<T> builder,
  T? inject,
  bool watchAllStorageKeys = false,
  List<String> watchStorageKeys = const [],
  List<OkitoController> otherControllers = const [],
}) {
  if (inject != null) Okito.inject(inject);

  final controller = Okito.use<T>();
  return OkitoBuilder(
    controller: controller,
    watchAllStorageKeys: watchAllStorageKeys,
    watchStorageKeys: watchStorageKeys,
    otherControllers: otherControllers,
    builder: () => builder(controller),
  );
}
