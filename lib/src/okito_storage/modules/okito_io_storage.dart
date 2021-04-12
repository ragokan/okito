import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

/// The OkitoStorage implementation for web.
class ImplOkitoStorage {
  bool _isInitialized = false;

  final Map<String, dynamic> _emptyData = {};

  Map<String, dynamic> _currentData = {};
  String get _encodedData => jsonEncode(_currentData);

  /// The file that we are writing all the data.
  /// Whenever we import storage, the file is created automatically
  /// if the file doesn't exists.
  late final File _file;

  /// Inıtializes the io version of storage, it is async because of
  /// the path library, an amazingly simple library that gives us
  /// documents directory of app.
  Future<void> init({required String storageName}) async {
    var appDocDirectory = await getApplicationDocumentsDirectory();
    var path = appDocDirectory.path;
    var slash = Platform.isWindows ? '\\' : '/';
    var dir = '$path$slash$storageName.okitoStorage';
    File(dir).createSync(recursive: true);
    _file = File(dir);
    _currentData = _getData();
    _isInitialized = true;
  }

  Map<String, dynamic> _getData() {
    try {
      var stringData = _file.readAsStringSync();
      return stringData.trim() == ''
          ? _emptyData
          : jsonDecode(stringData) ?? _emptyData;
    } on FormatException catch (_) {
      clearStorage();
      return _emptyData;
    }
  }

  void _saveToIOStorage() => _file.writeAsStringSync(_encodedData);

  /// Get data from local storage.
  T? read<T>(String key) => _isInitialized ? _currentData[key] : null;

  /// Get all keys from local storage.
  List<String>? readAllKeys() =>
      _isInitialized ? _currentData.keys.toList() : null;

  /// Get all values from local storage.
  List<dynamic>? readAllValues() =>
      _isInitialized ? _currentData.values.toList() : null;

  /// Get everything from local storage.
  Map<String, dynamic>? readAll() => _isInitialized ? _currentData : null;

  /// Writes current data to the local storage.
  void write<T>(String key, T value) {
    if (!_isInitialized) return;
    _currentData[key] = value;
    _saveToIOStorage();
  }

  /// Deletes a key from the storage.
  void removeKey<T>(String key) {
    if (!_isInitialized) return;
    _currentData.remove(key);
    _saveToIOStorage();
  }

  /// Clear the data of local storage.
  void clearStorage() {
    if (!_isInitialized) return;

    _file.writeAsStringSync(jsonEncode(_emptyData));
  }

  /// Delete the storage permanently.
  void deleteStorage() {
    if (!_isInitialized) return;
    _file.deleteSync();
  }
}
