import 'dart:async';

mixin OkitoFunctions {
  /// [seconds] is the amount of time that Okito wait to call the function.
  /// after x [seconds], [callback] funciton will be called.
  ///
  /// Example
  ///
  /// ```dart
  /// Okito.setTimeout(5, () => print('5 second passed'));
  /// ```
  void setTimeout(int seconds, Function callback) =>
      Timer(Duration(seconds: seconds), () => callback());

  /// [seconds] is the amount of time that Okito will wait to call
  /// the function again, it will continiously work.
  ///
  /// Returns a function that can stop the interval.
  ///
  /// Example
  ///
  /// ```dart
  /// final stopInterval = Okito.setInterval(5, () {
  ///   print('I will run every 5 seconds');
  /// });
  /// Okito.setTimeout(20, stopInterval);
  /// ```
  Function setInterval(int seconds, Function callback) {
    final timer = Timer.periodic(Duration(seconds: seconds), (_) => callback());
    return timer.cancel;
  }
}
