import '../../okito.dart';

/// The base of [Okito] dependency injection.
///
/// We just mix this class with the [Okito], then we can use it.
///
/// It is a totally undependent mixin, no override or anything required.
mixin OkitoDependencyInjection {
  /// A [Set] of injected [_dependencies].
  /// It is set because we don't want to have duplicates.
  final Set _dependencies = <dynamic>{};

  /// Injects the dependency to the [Okito], so that you can use it
  /// with [use] function.
  ///
  /// It also returns the dependency, so you can directly use it.
  ///
  /// ```dart
  /// final counter = Okito.inject(Counter());
  /// counter.count++;
  ///
  /// // or
  /// Okito.inject(Counter());
  /// Okito.use<Counter>().count++;
  /// ```
  T inject<T>(T dependency) {
    _dependencies.add(dependency);
    if (T is OkitoController) {
      // We call the onInject method if the controller is [OkitoController].
      (dependency as OkitoController).onInject();
    }
    return dependency;
  }

  /// Removes the dependency that is injected before with [inject] function.
  ///
  /// ```dart
  /// Okito.eject<Counter>();
  /// ```
  ///
  /// Good for memory, if you don't use dependency, just kill it :D
  /// After you [eject], you won't be able to [use] it anymore.
  void eject<T>() => _dependencies.removeWhere((dependency) => dependency is T);

  /// Returns the dependency that is injected before with [inject] function.
  ///
  /// ```dart
  /// Okito.use<Counter>().count++;
  /// ```
  ///
  /// If you are going to use [use] function multiple times in your code,
  /// it is best to assign it to a variable.
  /// ```dart
  /// final counter = Okito.use<Counter>();
  /// counter.count++;
  /// counter.count--;
  /// ```
  T use<T>() => _dependencies.firstWhere((dependency) => dependency is T,
      orElse: () => throw Exception('''
      You have to inject a variable to use it with [use] function.
      Please read the documents or hover over the [use] function to see its usage.
      Note that you can't use type [dynamic] with [use] function.
        '''));

  /// Same as [use] function, use whichever you want :)
  T take<T>() => use<T>();

  /// It is going to be our second store for dependencies but for key storage.
  final Map<String, dynamic> _dependenciesWithKey = <String, dynamic>{};

  /// It works just like [inject] function, but instead of just type,
  /// you give it a key. It is mostly suitable for usages of same type more
  /// than once.
  ///
  /// ```dart
  /// Okito.injectWithKey('yourKey',yourValue);
  ///
  /// // They are different instances to use.
  /// Okito.injectWithKey('controller1',CounterController());
  /// Okito.injectWithKey('controller2',CounterController());
  ///
  /// ```
  /// To use, check [useWithKey], to remove, check [ejectWithKey].
  T injectWithKey<T>(String key, T dependency) {
    _dependenciesWithKey[key] = dependency;
    return dependency;
  }

  /// It works just like [use] function, but instead of type, you use with key.
  /// You have to inject using [injectWithKey] function first.
  /// ```dart
  /// final appSecret = Okito.useWithKey<String>('appSecret');
  /// final firstCounterController =
  ///     Okito.useWithKey<CounterController>('controller1');
  /// final secondCounterController =
  ///     Okito.useWithKey<CounterController>('controller2');
  /// ```
  T useWithKey<T>(String key) {
    if (_dependenciesWithKey.containsKey(key)) {
      return _dependenciesWithKey[key];
    }

    throw Exception('''
      You have to inject a variable with key to use [useWithKey] function.
      Please read the documents or hover over the [useWithKey] function to see its usage.
      Note that you can't use type [dynamic] with [useWithKey] function.
        ''');
  }

  /// It works just like [eject] function, but instead of just type,
  /// you give it a key.
  ///
  /// ```dart
  /// Okito.ejectWithKey('yourKey');
  /// ```
  void ejectWithKey<T>(String key) => _dependenciesWithKey.remove(key);
}
