import '../../../typedefs/callback_types.dart';

class StorageWatcher<T> {
  final String? key;
  final VoidCallback callback;

  const StorageWatcher({this.key, required this.callback});
}
