import '../types/callback_types.dart';

class Listener<T> {
  final T event;
  final CallbackPayload callback;

  Listener(this.event, this.callback);
}
