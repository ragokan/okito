import 'package:flutter_test/flutter_test.dart';
import 'package:okito/okito.dart';

final box = OkitoStorage;

void main() async {
  await box.init(storageName: 'test_okito_storage');
  test('testBox', () {
    var values = box.read<List>('numbers') ?? [];

    expect(values, []);

    values.add(values.length);
    box.write('numbers', values);

    expect(values, box.read('numbers'));

    box.write('numbers', []);

    expect(box.read('numbers'), []);
  });

  box.deleteStorage();
}
