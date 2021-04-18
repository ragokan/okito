import '../../okito.dart';
import '../typedefs/callback_types.dart';
import 'controller.dart';
import 'modules/communication.dart';

/// [RockitoWatcher] is the easiest and the most lightweight way to observe
/// controller changes outside of [OkitoBuilder] using *Rockitos*.
///
/// It differs from [RockitoBuilder] in one way, [RockitoBuilder] creates a
/// StatefulWidget to observe changes, so that you can display your widget, but
/// [RockitoWatcher] doesn't create any widget, it is just a callback function
/// that gives you access to the state and watch state changes of your
/// [OkitoController].
///
/// Example
///
/// ```dart
///            // This type is required.
/// RockitoWatcher<CounterController>(
///   (controller) {
///       print('Count is changed to ${controller.count}');
///   },
/// )
/// ```
// ignore: non_constant_identifier_names
Function RockitoWatcher<T extends OkitoController>(
  /// The function that called whenever controller state changes.
  /// (controller) => /* Your code here */
  WatcherCallback<T> callback, {
  T? inject,
}) {
  if (inject != null) Okito.inject(inject);
  final _watch = Okito.use<T>();
  return controllerXviewStream.watch(
    _watch,
    () => callback(_watch),
  );
}
