import 'dart:convert';
import 'dart:html' as html;
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

class _OkitoStorage {
  bool _isInitialized = false;

  /// Just an [_emptyData] that has nothing, good for type support.
  final Map<String, dynamic> _emptyData = {};

  /// Current data, initially is empty, we update it over time.
  Map<String, dynamic> _currentData = {};
  String get _encodedData => jsonEncode(_currentData);

  /// The file that we are writing all the data.
  /// Whenever we import storage, the file is created automatically
  /// if the file doesn't exists.
  final File _file = File('.${Platform.isWindows ? '\\' : '/'}.okitoStorage');

  final String _key = 'okitoStorage';

  html.Storage get localStorage => html.window.localStorage;

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
  void init() {
    if (!kIsWeb) {
      File('.${Platform.isWindows ? '\\' : '/'}.$_key').createSync();
    } else {
      if (!localStorage.containsKey(_key)) {
        localStorage[_key] = jsonEncode(_emptyData);
      }
    }
    _currentData = _getData();
    _isInitialized = true;
  }

  /// [_getData] is the way to get the data with encoding.
  Map<String, dynamic> _getData() {
    try {
      if (!kIsWeb) {
        var stringData = _file.readAsStringSync();
        return stringData.trim() == ''
            ? _emptyData
            : jsonDecode(stringData) ?? _emptyData;
      } else {
        return localStorage.containsKey(_key)
            ? jsonDecode(localStorage[_key]!)
            : _emptyData;
      }
    } on FormatException catch (_) {
      clearStorage();
      return _emptyData;
    }
  }

  /// Saves current data to the local storage.
  void _saveToWebStorage() => localStorage[_key] = _encodedData;
  void _saveToIOStorage() => _file.writeAsStringSync(_encodedData);

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
  T? read<T>(String key) => _isInitialized ? _currentData[key] : null;

  /// Returns all the keys of storage.
  ///
  /// Usage
  ///
  /// ```dart
  /// final allKeys = OkitoStorage.readAllKeys();
  /// ```
  List<String>? readAllKeys() =>
      _isInitialized ? _currentData.keys.toList() : null;

  /// Returns all the values of storage.
  ///
  /// Usage
  ///
  /// ```dart
  /// final allKeys = OkitoStorage.readAllValues();
  /// ```

  List<dynamic>? readAllValues() =>
      _isInitialized ? _currentData.values.toList() : null;

  /// Returns everything that exists in the storage.
  ///
  /// Usage
  ///
  /// ```dart
  /// final allKeys = OkitoStorage.readAll();
  /// ```
  Map<String, dynamic>? readAll() => _isInitialized ? _currentData : null;

  /// Writes a value to the storage with a key.
  ///
  /// Usage
  ///
  /// ```dart
  /// OkitoStorage.write<String>('myName','Okito');
  /// ```
  void write<T>(String key, T value) {
    if (!_isInitialized) return;
    _currentData[key] = value;
    kIsWeb ? _saveToWebStorage() : _saveToIOStorage();
  }

  /// Writes a value to the storage with a key if the key's value is null.
  ///
  /// Usage
  ///
  /// ```dart
  /// OkitoStorage.write<String>('myName','Okito');
  /// ```
  void writeIfNull<T>(String key, T value) {
    if (!_isInitialized) return;
    if (!_currentData.containsKey(key)) {
      _currentData[key] = value;
      kIsWeb ? _saveToWebStorage() : _saveToIOStorage();
    }
  }

  /// Writes a value to the storage with a key if the key's value is null.
  ///
  /// Usage
  ///
  /// ```dart
  /// OkitoStorage.write<String>('myName','Okito');
  /// ```
  void removeKey<T>(String key) {
    if (!_isInitialized) return;
    _currentData.remove(key);
    kIsWeb ? _saveToWebStorage() : _saveToIOStorage();
  }

  /// Deletes all keys and values from the storage, the file
  /// will still stay at its location.
  void clearStorage() {
    if (!_isInitialized) return;
    kIsWeb
        ? localStorage[_key] = jsonEncode(_emptyData)
        : _file.writeAsStringSync(jsonEncode(_emptyData));
  }

  /// Deletes the file and data completely.
  void deleteStorage() {
    if (!_isInitialized) return;
    kIsWeb ? localStorage.remove(_key) : _file.deleteSync();
  }
}

// ignore: non_constant_identifier_names
_OkitoStorage OkitoStorage = _OkitoStorage();
