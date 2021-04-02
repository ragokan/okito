import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class ImplOkitoStorage {
  bool _isInitialized = false;

  final Map<String, dynamic> _emptyData = {};

  Map<String, dynamic> _currentData = {};
  String get _encodedData => jsonEncode(_currentData);

  /// The file that we are writing all the data.
  /// Whenever we import storage, the file is created automatically
  /// if the file doesn't exists.
  late final File _file;

  final String _key = 'okitoStorage';

  Future<void> init() async {
    var appDocDirectory = await getApplicationDocumentsDirectory();

    var dir = '$appDocDirectory${Platform.isWindows ? '\\' : '/'}.$_key';
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

  T? read<T>(String key) => _isInitialized ? _currentData[key] : null;

  List<String>? readAllKeys() =>
      _isInitialized ? _currentData.keys.toList() : null;

  List<dynamic>? readAllValues() =>
      _isInitialized ? _currentData.values.toList() : null;

  Map<String, dynamic>? readAll() => _isInitialized ? _currentData : null;

  void write<T>(String key, T value) {
    if (!_isInitialized) return;
    _currentData[key] = value;
    _saveToIOStorage();
  }

  void writeIfNull<T>(String key, T value) {
    if (!_isInitialized) return;
    if (!_currentData.containsKey(key)) {
      _currentData[key] = value;
      _saveToIOStorage();
    }
  }

  void removeKey<T>(String key) {
    if (!_isInitialized) return;
    _currentData.remove(key);
    _saveToIOStorage();
  }

  void clearStorage() {
    if (!_isInitialized) return;

    _file.writeAsStringSync(jsonEncode(_emptyData));
  }

  void deleteStorage() {
    if (!_isInitialized) return;
    _file.deleteSync();
  }
}
