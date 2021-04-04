import '../../okito.dart';

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
    return dependency;
  }

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
  T use<T>() => _dependencies.firstWhere(
      (dependency) => dependency.runtimeType.toString() == T.toString(),
      orElse: () => throw Exception('''
      You have to declare a variable to use [use] function.
      Please read the documents or hover over the [use] function to see its usage.
      Note that you can't use type [dynamic] with [use] function.
        '''));
}
