import '../../../typedefs/callback_types.dart';
import '../controller.dart';
import 'watcher_model.dart';

class _ControllerCommunication<Okito> {
  final _watchers = <Watcher>{};

  /// [notify] method is the method called when you use 'update' or 'setState'.
  void notify<T extends Okito>(T controller) {
    for (var watcher in _watchers) {
      if (watcher.controller == controller) {
        watcher.callback();
      }
    }
  }

  /// With [watch] method, state watches changes that are coming from notify.
  Function watch<T extends Okito>(
    T controller,
    VoidCallback callback,
  ) {
    var watcher = Watcher(controller, callback);
    _watchers.add(watcher);

    return () => _watchers.remove(watcher);
  }
}

/// ### For Developers
///
/// The [controllerXview] is a bridge between controller
///  and view(stateful widget).
///
/// In the okito, we don't use Dependency Injection, instead we use
/// set with watchers which is triggered whenever a controller
/// notifies the state to update/re-build.
final _ControllerCommunication controllerXview =
    _ControllerCommunication<OkitoController>();
