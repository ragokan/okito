import 'package:flutter/material.dart';

import '../../types/callback_types.dart';
import 'controller.dart';
import 'modules/communication.dart';

/// [OkitoBuilder] is the easiest way to track state changes and
/// re-render state on change.
///
/// Instead of having a stateful widget that re-renders on any change
/// which causes all the dependencies to re-render no matter if they
/// are changed or not, StatelessWidget with OkitoBuilder just re-renders
/// where did you use OkitoBuilder. If your widget don't need a dynamic
/// state, just don't put it inside builder. It won't re-built.
///
/// Example
///
/// ```dart
/// OkitoBuilder(
/// controller: counterController,
/// builder: () => Text('${counterController.count}',
///   ),
/// );
/// ```
class OkitoBuilder<T extends OkitoController> extends StatefulWidget {
  /// [controller] should be a class that extends or mixs [OkitoController].
  final T controller;

  /// If you have more than one [controller], you can create an array of
  /// [controller]s.
  final List<T> otherControllers;

  /// Builder callback is called whenever your state changes.
  ///
  /// You have to return a Widget that you want to re-build on state changes.
  final BuilderCallback builder;

  /// OkitoBuilder is the way to use OkitoController.
  ///
  /// Its main advantage is having a builder that just re-renders itself on
  /// state change which means that your other widgets that doesn't depend
  /// on your state won't re-build on update.
  ///
  /// Usage is simple, just create an [OkitoController] just like it is declared
  /// in its documentation, then show that controller when you call the builder.
  ///
  /// Example
  ///
  ///```dart
  /// OkitoBuilder(
  ///        controller: counterController,
  ///        builder: () => Text('Current count is ${counterController.count}'),
  ///        ),
  /// ```
  ///
  /// Example With Multiple Controllers
  ///
  ///```dart
  /// OkitoBuilder(
  ///        controller: counterController,
  ///        otherControllers: [ageController, userController /* and other controllers */],
  ///        builder: () => Text('Current count is ${counterController.count}'),
  ///        ),
  /// ```
  const OkitoBuilder({
    Key? key,
    required this.controller,
    this.otherControllers = const [],
    required this.builder,
  }) : super(key: key);

  @override
  _OkitoBuilderState createState() => _OkitoBuilderState();
}

class _OkitoBuilderState extends State<OkitoBuilder> {
  List<Function> unmountFunctions = [];

  @protected
  @override
  void initState() {
    super.initState();

    /// Here, we mount the [watch] function to re-render state on changes.
    final unmount =
        controllerXview.watch(widget.controller, () => setState(() {}));
    unmountFunctions.add(unmount);

    /// Just like the above example, here we mount all of the controllers
    /// that build method wants to watch.
    widget.otherControllers.forEach((controller) {
      final unmount = controllerXview.watch(controller, () => setState(() {}));
      unmountFunctions.add(unmount);
    });
  }

  @protected
  @override
  void dispose() {
    super.dispose();

    /// On dispose, we would like to unmount the watchers, so that
    /// we don't leak the memory and the [notify] function don't
    /// call the [watch] function.
    unmountFunctions.forEach((unmount) => unmount());
  }

  @override
  Widget build(_) => widget.builder();
}
