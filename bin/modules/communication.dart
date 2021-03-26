import '../types/callback_types.dart';
import 'listener.dart';

class ControllerCommunication<Okito> {
  final _listeners = <Listener>{};

  void notify<T extends Okito>(Object message) {
    for (var listener in _listeners) {
      if (listener.event == T) {
        listener.callback(message);
      }
    }
  }

  void watch<T extends Okito>(VoidCallback<Object> callback) {
    var listener = Listener(T, callback as void Function(dynamic));
    _listeners.add(listener);
  }
}
