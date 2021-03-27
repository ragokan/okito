import '../types/callback_types.dart';

class Listener<T> {
  final T event;
  final VoidCallback callback;

  const Listener(this.event, this.callback);
}
