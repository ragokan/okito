import '../types/callback_types.dart';
import 'controller.dart';
import 'listener.dart';

class ControllerCommunication<Okito> {
  final _listeners = <Listener>{};

  void notify<T extends Okito>() {
    for (var listener in _listeners) {
      if (listener.event == T) {
        listener.callback();
      }
    }
  }

  void watch<T extends Okito>(VoidCallback<Object> callback) {
    var listener = Listener(T, callback);
    _listeners.add(listener);
  }
}

ControllerCommunication communication =
    ControllerCommunication<OkitoController>();
