import '../bin/controller.dart';
import '../types/callback_types.dart';
import 'listener.dart';

class _ControllerCommunication<Okito> {
  final _listeners = <Listener>{};

  /// [notify] method is the method called when you use 'update' or 'setState'.
  void notify<T extends Okito>(T type) {
    for (var listener in _listeners) {
      if (listener.event == type) {
        listener.callback();
      }
    }
  }

  /// With [watch] method, state watches changes that are coming from notify.
  Function watch<T extends Okito>(T type, VoidCallback<Object> callback) {
    var listener = Listener(type, callback);
    _listeners.add(listener);

    return () => _listeners.remove(listener);
  }
}

final _ControllerCommunication controllerXstate =
    _ControllerCommunication<OkitoController>();
