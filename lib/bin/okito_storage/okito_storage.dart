import '../../typedefs/callback_types.dart';

// I learned this usage from https://github.com/gskinnerTeam/flutter-universal-platform/blob/master/lib/universal_platform.dart
import 'modules/okito_web_storage.dart'
    if (dart.library.io) 'modules/okito_io_storage.dart';
import 'modules/storage_watcher_model.dart';

class _OkitoStorage extends ImplOkitoStorage {
  final _watchers = <StorageWatcher>{};

  /// [_notify] is the method that notifies all watchers.
  void _notify(String key) => _watchers.forEach((element) {
        /// These elements are coming from [watchAll]
        /// they don't have any key.
        if (element.key == null) return element.callback();
        if (element.key == key) element.callback();
      });

  /// [watchKey] gives you a callback that called whenever the [key]
  /// you declared changes/creates.
  ///
  /// Usage
  ///
  /// ```dart
  /// watchKey('count',() => {
  ///   print('Count is changed');
  /// });
  /// ```
  Function watchKey(String key, VoidCallback callback) {
    var watcher = StorageWatcher(key: key, callback: callback);
    _watchers.add(watcher);
    return () => _watchers.remove(watcher);
  }

  /// [watchAll] gives you a callback that called whenever any key changes/creates.
  ///
  /// Usage
  ///
  /// ```dart
  /// watchAll(() => {
  ///   print('Something is changed');
  /// });
  /// ```
  Function watchAll(VoidCallback callback) {
    var watcher = StorageWatcher(callback: callback);
    _watchers.add(watcher);
    return () => _watchers.remove(watcher);
  }

  /// [init] function is required to start [OkitoStorage]
  ///
  /// The best practice to use it is using the function at the start of *main*
  /// function of your project.
  ///
  /// Example
  ///
  /// ```dart
  ///void main(List<String> arguments) {
  ///  OkitoStorage.init();
  /// // Rest of your code
  ///}
  ///```
  @override
  Future<void> init({String storageName = 'okito'}) async =>
      await super.init(storageName: storageName.trim());

  /// Reads the storage, if there are any match with the key, it returns
  /// the value of it. If there are no match, it will return null.
  ///
  /// You can give a type as its return type but it should match the
  /// written type.
  ///
  /// Usage
  ///
  /// ```dart
  /// final myName = OkitoStorage.read<String>('myName');
  /// ```
  @override
  T? read<T>(String key) => super.read(key);

  /// Returns all the keys of storage.
  ///
  /// Usage
  ///
  /// ```dart
  /// final allKeys = OkitoStorage.readAllKeys();
  /// ```
  @override
  List<String>? readAllKeys() => super.readAllKeys();

  /// Returns all the values of storage.
  ///
  /// Usage
  ///
  /// ```dart
  /// final allKeys = OkitoStorage.readAllValues();
  /// ```

  @override
  List<dynamic>? readAllValues() => super.readAllValues();

  /// Returns everything that exists in the storage.
  ///
  /// Usage
  ///
  /// ```dart
  /// final allKeys = OkitoStorage.readAll();
  /// ```
  @override
  Map<String, dynamic>? readAll() => super.readAll();

  /// Writes a value to the storage with a key.
  ///
  /// Usage
  ///
  /// ```dart
  /// OkitoStorage.write<String>('myName','Okito');
  /// ```
  @override
  void write<T>(String key, T value) {
    super.write(key, value);
    _notify(key);
  }

  /// Writes a value to the storage with a key if the key's value is null.
  ///
  /// Usage
  ///
  /// ```dart
  /// OkitoStorage.write<String>('myName','Okito');
  /// ```
  @override
  void removeKey<T>(String key) {
    super.removeKey(key);
    _notify(key);
  }

  /// Deletes all keys and values from the storage, the file
  /// will still stay at its location.
  @override
  void clearStorage() {
    super.clearStorage();
    _notify('');
  }

  /// Deletes the file and data completely.
  @override
  void deleteStorage() {
    super.deleteStorage();
    _notify('');
  }
}

/// [OkitoStorage] is a local storage implementation for *Okito*.
///
/// Main methods are [OkitoStorage.read()] and [OkitoStorage.write(key, value)]
///
/// To use it, you should add this line to your main function.
///
/// ```dart
/// await OkitoStorage.init();
/// ```
// ignore: non_constant_identifier_names
final _OkitoStorage OkitoStorage = _OkitoStorage();
