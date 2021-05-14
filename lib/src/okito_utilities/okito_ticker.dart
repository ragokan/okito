import 'package:flutter/scheduler.dart';

/// A simple ticker provider mixin.
/// Usage:
///
/// ```dart
/// class YourController extends OkitoController with OkitoTickerProviderMixin{
///     // Now you can use your animation controllers here
///     // 'This' in vsync is the OkitoTickerProviderMixin
///    TabController controller = TabController(vsync: this, length:3);
///   }
/// ```
mixin OkitoTickerProviderMixin implements TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) => Ticker(onTick);
}
