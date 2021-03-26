import '../types/callback_types.dart';
import 'listener.dart';

class ControllerCommunication<Okito> {
  final _listeners = <Listener>{};

  void notify<T extends Okito, X>(X message) {
    for (var listener in _listeners) {
      if (listener.event == T) {
        listener.callback(message);
      }
    }
  }

  void watch<T extends Okito, X>(VoidCallback<X> callback) {
    var listener = Listener(T, callback as void Function(dynamic));
    _listeners.add(listener);
  }
}
