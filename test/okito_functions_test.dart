import 'package:flutter_test/flutter_test.dart';
import 'package:okito/okito.dart';

void main() {
  test('setTimeout triggers after duration', () async {
    var fired = false;
    Okito.setTimeout(1, () => fired = true);
    await Future<void>.delayed(const Duration(milliseconds: 1200));
    expect(fired, true);
  });

  test('setInterval can be cancelled', () async {
    var count = 0;
    final cancel = Okito.setInterval(1, () => count++);
    await Future<void>.delayed(const Duration(milliseconds: 2200));
    cancel();
    final snapshot = count;
    await Future<void>.delayed(const Duration(milliseconds: 1500));
    expect(count, snapshot);
  });
}