import '../../typedefs/callback_types.dart';

/// The model for storage watchers.
///
/// Required for watch functions.
class StorageWatcher<T> {
  /// The key of storage to watch changes that calls [callback].
  final String? key;

  /// The callback function that is called when the listened [key] changes.
  final VoidCallback callback;

  /// The Constructor of [StorageWatcher], and luckily it is constant!
  const StorageWatcher({this.key, required this.callback});
}
