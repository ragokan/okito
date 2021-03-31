import '../../../types/callback_types.dart';

class Watcher<T> {
  final T event;
  final VoidCallback callback;

  const Watcher(this.event, this.callback);
}
