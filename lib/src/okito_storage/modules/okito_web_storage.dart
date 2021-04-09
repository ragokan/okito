import 'dart:convert';
import 'dart:html' as html;

class ImplOkitoStorage {
  bool _isInitialized = false;

  final Map<String, dynamic> _emptyData = {};

  Map<String, dynamic> _currentData = {};
  String get _encodedData => jsonEncode(_currentData);

  final String _key = 'okitoStorage';

  html.Storage get localStorage => html.window.localStorage;

  // Future for IO version.
  Future<void> init({required String storageName}) async {
    if (!localStorage.containsKey(_key)) {
      localStorage[_key] = jsonEncode(_emptyData);
    }
    _currentData = _getData();
    _isInitialized = true;
  }

  Map<String, dynamic> _getData() {
    try {
      return localStorage.containsKey(_key)
          ? jsonDecode(localStorage[_key]!)
          : _emptyData;
    } on FormatException catch (_) {
      clearStorage();
      return _emptyData;
    }
  }

  void _saveToWebStorage() => localStorage[_key] = _encodedData;

  T? read<T>(String key) => _isInitialized ? _currentData[key] : null;

  List<String>? readAllKeys() =>
      _isInitialized ? _currentData.keys.toList() : null;

  List<dynamic>? readAllValues() =>
      _isInitialized ? _currentData.values.toList() : null;

  Map<String, dynamic>? readAll() => _isInitialized ? _currentData : null;

  void write<T>(String key, T value) {
    if (!_isInitialized) return;
    _currentData[key] = value;
    _saveToWebStorage();
  }

  void removeKey<T>(String key) {
    if (!_isInitialized) return;
    _currentData.remove(key);
    _saveToWebStorage();
  }

  void clearStorage() {
    if (!_isInitialized) return;

    localStorage[_key] = jsonEncode(_emptyData);
  }

  void deleteStorage() {
    if (!_isInitialized) return;
    localStorage.remove(_key);
  }
}
