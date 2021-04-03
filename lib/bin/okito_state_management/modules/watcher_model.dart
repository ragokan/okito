import '../../../typedefs/callback_types.dart';

class Watcher<T> {
  /// The OkitoController
  final T controller;

  /// A callback function that is called whenever the controller calls
  /// *update* or *setState*
  final VoidCallback callback;

  const Watcher(this.controller, this.callback);
}
