import '../../okito.dart';
import '../typedefs/callback_types.dart';
import 'controller.dart';
import 'modules/communication.dart';

/// [OkitoWatcher] is the easiest and the most lightweight way to observe
/// controller changes outside of [OkitoBuilder].
///
/// It differs from [OkitoBuilder] in one way, [OkitoBuilder] creates a
/// StatefulWidget to observe changes, so that you can display your widget, but
/// [OkitoWatcher] doesn't create any widget, it is just a callback function
/// that gives you access to the state and watch state changes of your
/// [OkitoController].
///
/// Example
///
/// ```dart
/// // You can give a type here optionally to receive maximum type support.
/// OkitoWatcher<CounterController>(
///   watch: counterController,
///   onChange: (controller) {
///       print('Count is changed to ${controller.count}');
///   },
/// )
/// ```
// ignore: non_constant_identifier_names
Function OkitoWatcher<T extends OkitoController>({
  /// Controller to watch
  required T watch,

  /// The function that called whenever controller state changes.
  /// onChange: (controller) => /* Your code here */
  required WatcherCallback<T> onChange,
}) {
  return controllerXview.watch(
    watch,
    () => onChange(watch),
  );
}
