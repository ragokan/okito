import 'dart:io';

import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

class FakePathProviderPlatform extends PathProviderPlatform {
  final Directory root;
  FakePathProviderPlatform({Directory? root}) : root = root ?? Directory.systemTemp.createTempSync('okito_test_');

  Directory _ensure(String name) {
    final dir = Directory('${root.path}/$name');
    if (!dir.existsSync()) {
      dir.createSync(recursive: true);
    }
    return dir;
  }

  @override
  Future<String?> getTemporaryPath() async => _ensure('tmp').path;

  @override
  Future<String?> getApplicationSupportPath() async => _ensure('app_support').path;

  @override
  Future<String?> getApplicationDocumentsPath() async => _ensure('app_docs').path;

  @override
  Future<String?> getDownloadsPath() async => _ensure('downloads').path;

  @override
  Future<String?> getLibraryPath() async => _ensure('library').path;

  @override
  Future<String?> getApplicationCachePath() async => _ensure('app_cache').path;

  @override
  Future<List<String>?> getExternalCachePaths() async => <String>[_ensure('ext_cache').path];

  @override
  Future<String?> getExternalStoragePath() async => _ensure('ext_storage').path;

  @override
  Future<List<String>?> getExternalStoragePaths({StorageDirectory? type}) async => <String>[_ensure('ext_storage_paths').path];
}

void installFakePathProvider({Directory? root}) {
  PathProviderPlatform.instance = FakePathProviderPlatform(root: root);
}