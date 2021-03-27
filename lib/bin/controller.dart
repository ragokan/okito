import 'package:flutter/foundation.dart';

import '../modules/communication.dart';
import '../types/callback_types.dart';

class OkitoController {
  @mustCallSuper
  void update() => communication.notify(this);

  @mustCallSuper
  void setState(VoidCallback callback) {
    callback();
    update();
  }
}
