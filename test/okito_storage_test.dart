import 'package:flutter_test/flutter_test.dart';
import 'package:okito/okito.dart';

final box = OkitoStorage;

void main() async {
  /// Firstly we have to init the storage, for web, we don't have to init.
  ///
  /// You may not [await] but it is not recommended.
  await box.init(storageName: 'test_okito_storage');
  test('testBox', () {
    /// [values] is empty, we didn't write it.
    var values = box.read<List>('numbers') ?? [];

    expect(values, []);

    values.add(values.length);

    /// We write current [values] to the [box.]
    ///
    /// Basically ['numbers'] are now equals to [0]
    box.write('numbers', values);

    expect(values, box.read('numbers'));

    /// Then we clear all the elements in ['numbers'].
    box.write('numbers', []);

    expect(box.read('numbers'), []);
  });

  /// At the end, we delete the storage permanently from the disk.
  box.deleteStorage();
}
