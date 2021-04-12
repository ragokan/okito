import 'dart:convert';
import 'dart:html' as html;

/// The OkitoStorage implementation for web.
class ImplOkitoStorage {
  bool _isInitialized = false;

  final Map<String, dynamic> _emptyData = {};

  Map<String, dynamic> _currentData = {};
  String get _encodedData => jsonEncode(_currentData);

  final String _key = 'okitoStorage';

  html.Storage get _localStorage => html.window.localStorage;

  /// Future for IO version.
  /// Inits the local storage and get current data.
  Future<void> init({required String storageName}) async {
    if (!_localStorage.containsKey(_key)) {
      _localStorage[_key] = jsonEncode(_emptyData);
    }
    _currentData = _getData();
    _isInitialized = true;
  }

  Map<String, dynamic> _getData() {
    try {
      return _localStorage.containsKey(_key)
          ? jsonDecode(_localStorage[_key]!)
          : _emptyData;
    } on FormatException catch (_) {
      clearStorage();
      return _emptyData;
    }
  }

  void _saveToWebStorage() => _localStorage[_key] = _encodedData;

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
    _saveToWebStorage();
  }

  /// Deletes a key from the storage.
  void removeKey<T>(String key) {
    if (!_isInitialized) return;
    _currentData.remove(key);
    _saveToWebStorage();
  }

  /// Clear the data of local storage.
  void clearStorage() {
    if (!_isInitialized) return;

    _localStorage[_key] = jsonEncode(_emptyData);
  }

  /// Delete the storage permanently.
  void deleteStorage() {
    if (!_isInitialized) return;
    _localStorage.remove(_key);
  }
}
