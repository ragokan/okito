import 'package:flutter_test/flutter_test.dart';
import 'package:okito/okito.dart';

class Config {
  final String name;
  Config(this.name);
}

void main() {
  test('inject/use/eject with key works', () {
    Okito.injectWithKey<Config>('cfg1', Config('alpha'));
    Okito.injectWithKey<Config>('cfg2', Config('beta'));

    final first = Okito.useWithKey<Config>('cfg1');
    final second = Okito.useWithKey<Config>('cfg2');

    expect(first.name, 'alpha');
    expect(second.name, 'beta');

    Okito.ejectWithKey<Config>('cfg1');

    expect(() => Okito.useWithKey<Config>('cfg1'), throwsA(isA<Exception>()));
    expect(Okito.useWithKey<Config>('cfg2').name, 'beta');
  });
}