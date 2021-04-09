import 'package:flutter/material.dart';

import '../../okito.dart';
import '../typedefs/callback_types.dart';

/// [OkitoGarbageBuilder] is your way to use a controller only once.
///
/// It is useful when you require controller only for a screen, so it means
/// you are not using controller for state management but for seperating
/// view and logic.
///
/// Warnings
/// * This builder shouldn't be wrapped or affected by another builder.
/// * Don't use this builder inside StatefulWidget, it is both worst use case
/// and can cause problems
///
/// Example
///
/// ```dart
/// class CounterController(){
///   int count = 0;
/// }
///
/// OkitoGarbageBuilder<CounterController>(
///   garbage: CounterController(), // we instantiate it here
///   builder: (c) => Column(
///     children: [
///       Text('${c.count}'),
///       ElevatedButton(
///         onPressed: () => c.setState(() => c.count++),
///         child: const Text('Increment'),
///       )
///     ],
///   ),
/// );
/// ```
// ignore: non_constant_identifier_names
Widget OkitoGarbageBuilder<T extends OkitoController>({
  required ControllerCallback<T> builder,
  required T garbage,
}) =>
    OkitoBuilder<T>(
      controller: garbage,
      builder: () => builder(garbage),
    );
