// I learned this usage from https://github.com/gskinnerTeam/flutter-universal-platform/blob/master/lib/universal_platform.dart
import 'okito_web_storage.dart' if (dart.library.io) 'okito_io_storage.dart';

class _OkitoStorage extends ImplOkitoStorage {
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
  Future<void> init() async => await super.init();

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
  void write<T>(String key, T value) => super.write(key, value);

  /// Writes a value to the storage with a key if the key's value is null.
  ///
  /// Usage
  ///
  /// ```dart
  /// OkitoStorage.write<String>('myName','Okito');
  /// ```
  @override
  void writeIfNull<T>(String key, T value) => super.writeIfNull(key, value);

  /// Writes a value to the storage with a key if the key's value is null.
  ///
  /// Usage
  ///
  /// ```dart
  /// OkitoStorage.write<String>('myName','Okito');
  /// ```
  @override
  void removeKey<T>(String key) => super.removeKey(key);

  /// Deletes all keys and values from the storage, the file
  /// will still stay at its location.
  @override
  void clearStorage() => super.clearStorage();

  /// Deletes the file and data completely.
  @override
  void deleteStorage() => super.deleteStorage();
}

// ignore: non_constant_identifier_names
_OkitoStorage OkitoStorage = _OkitoStorage();
