import 'package:flutter/foundation.dart';

import '../typedefs/callback_types.dart';
import 'modules/communication.dart';
import 'state_methods.dart';

/// [OkitoController] is the head of okito state management.
///
/// To use this, you should extend or mix your controller class.
///
/// [OkitoController] gives you two important functions, [update] and [setState]
/// which helps you to re-build your builders.
///
/// Example
///
/// ```dart
///class CounterController extends OkitoController {
///  int count = 0;
///
///  void increment() => setState(() => count++);
///
///  void decrement() {
///    count--;
///    update();
///  }
/// }
///
/// CounterController counterController = CounterController();
///
/// ```
class OkitoController with OkitoStateMethods {
  const OkitoController();

  /// [update] method notifies all the builders to re-build the state.
  ///
  /// When you make a change in your state, you can call [update()] to update
  /// the state.
  ///
  /// It works just like the notifyListeners() of Provider or
  /// update() of Get.
  ///
  ///
  /// Example
  ///```dart
  ///void increment(){
  ///    count++;
  ///    update();
  ///}
  ///```
  ///
  @mustCallSuper
  void update() => controllerXview.notify(this);

  /// [setState] method notifies all the builders to re-build the state
  /// after the callback ends.
  ///
  /// It is totally same with [setState] of StatefulWidget.
  ///
  ///
  ///Example
  ///```dart
  ///void increment(){
  ///    setState(() {
  ///     count++;
  ///   });
  ///}
  ///```
  ///
  /// The [setState] can be async;
  /// ```dart
  ///   setState(() async{
  ///     // do something async
  ///     count++;
  ///   });
  /// ```
  ///
  /// You can also use expression to make your code shorter
  /// ```dart
  ///   void increment() => setState(() => count++);
  /// ```
  @mustCallSuper
  void setState(VoidCallback callback) {
    callback();
    update();
  }
}
