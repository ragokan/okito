import 'package:flutter_test/flutter_test.dart';
import 'package:okito/okito.dart';
import 'test_utils/mock_path_provider.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  installFakePathProvider();
  await OkitoStorage.init(storageName: 'okito_test_tmp');

  test('write/read/remove/clear/delete works', () {
    expect(OkitoStorage.readAll(), isNotNull);

    OkitoStorage.write('a', 1);
    OkitoStorage.write('b', 'two');

    expect(OkitoStorage.read<int>('a'), 1);
    expect(OkitoStorage.read<String>('b'), 'two');

    OkitoStorage.removeKey('a');
    expect(OkitoStorage.read('a'), isNull);

    OkitoStorage.clearStorage();
    expect(OkitoStorage.readAllKeys(), isEmpty);

    OkitoStorage.deleteStorage();
  });
}