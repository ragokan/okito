import '../../typedefs/callback_types.dart';

/// The watcher model for watching the state.
class Watcher<T> {
  /// The OkitoController
  final T toWatch;

  /// A callback function that is called whenever the controller calls
  /// *update* or *setState*
  final VoidCallback callback;

  /// Constructor (amazing docs, I know)
  const Watcher(this.toWatch, this.callback);
}
