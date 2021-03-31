import '../../../types/callback_types.dart';

class Watcher<T> {
  final T controller;
  final VoidCallback callback;

  const Watcher(this.controller, this.callback);
}
