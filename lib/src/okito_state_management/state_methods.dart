import '../../okito.dart';

/// The mixin that has some of stateful widget methods.
mixin OkitoStateMethods {
  /// [initState] methods is called when your [OkitoBuilder] is mounted
  /// to the widget tree.
  ///
  /// From flutter docs;
  ///
  /// Called when this object is inserted into the tree.
  ///
  /// The framework will call this method exactly once
  ///  for each *State* object it creates.
  void initState() {}

  /// [dispose] method is called when your [OkitoBuilder] is removed from
  /// the widget tree.
  ///
  /// From flutter docs;
  ///
  /// Called when this object is removed from the tree permanently.
  void dispose() {}

  /// [onInject] method is called only when you
  ///  *inject* it with [Okito.inject()]
  ///
  /// For example;
  /// ```dart
  /// class CounterController extends OkitoController{
  ///     @override
  ///     initController(){
  ///       print('CounterController is created!');
  ///    }
  /// }
  ///
  /// void main(){
  ///   Okito.inject(CounterController()); // initController is called now.
  /// }
  /// ```
  /// ---
  /// ---
  /// If you don't want to inject the controller, you can do this;
  /// ```dart
  ///  CounterController counterController = CounterController();
  ///
  /// void main(){
  ///   counterController.onInject();
  /// }
  /// ```
  void onInject() {}
}
