import '../bin/controller.dart';
import '../types/callback_types.dart';
import 'listener.dart';

class ControllerCommunication<Okito> {
  final _listeners = <Listener>{};

  void notify<T extends Okito>(T type) {
    for (var listener in _listeners) {
      if (listener.event == type) {
        listener.callback();
      }
    }
  }

  Function watch<T extends Okito>(T type, VoidCallback<Object> callback) {
    var listener = Listener(type, callback);
    _listeners.add(listener);

    return () => _listeners.remove(listener);
  }
}

ControllerCommunication communication =
    ControllerCommunication<OkitoController>();
