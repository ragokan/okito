import '../types/callback_types.dart';
import '../bin/controller.dart';
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

  void watch<T extends Okito>(T type, VoidCallback<Object> callback) {
    var listener = Listener(type, callback);
    _listeners.add(listener);
  }
}

ControllerCommunication communication =
    ControllerCommunication<OkitoController>();
