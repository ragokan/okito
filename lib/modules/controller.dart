import '../types/callback_types.dart';
import 'communication.dart';

class OkitoController<T> {
  void update() => communication.notify<T>();

  void setState(VoidCallback callback) {
    callback();
    update();
  }
}
