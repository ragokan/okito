import '../../modules/communication.dart';
import '../../types/callback_types.dart';
import 'controller.dart';

Function OkitoWatcher<T extends OkitoController>({
  required T watch,
  required WatcherCallback<T> onChange,
}) {
  return controllerXview.watch(
    watch,
    () => onChange(watch),
  );
}
