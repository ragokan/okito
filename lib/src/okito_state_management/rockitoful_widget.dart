import 'package:flutter/material.dart';
import '../../okito.dart';

import 'controller.dart';
import 'modules/communication.dart';

/// An implementation of StatefulWidget using Rockitos
class RockitofulWidget<T extends OkitoController> extends StatefulWidget {
  /// Describes the part of the user interface represented by this widget.
  Widget build(T controller) => const Material();

  /// Runs before build method, once.
  void initState() {}

  /// Runs before unmounting widget from lifecycle.
  void dispose() {}

  /// Runs the build method, again.
  void update() {
    Okito.use<T>().update();
  }

  /// Same as setState method of stateful widget.
  void setState(VoidCallback callback) async {
    callback();
    update();
  }

  /// You don't need to construct this widget.
  const RockitofulWidget({
    Key? key,
  }) : super(key: key);

  @override
  _RockitofulWidgetState createState() => _RockitofulWidgetState<T>();
}

class _RockitofulWidgetState<T extends OkitoController>
    extends State<RockitofulWidget> {
  _RockitofulWidgetState();
  final controller = Okito.use<T>();

  Function? _unmountFunction;

  bool _shouldUpdate = false;

  void _updateState() {
    if (!_shouldUpdate || !mounted) return;
    setState(() {});
  }

  @protected
  @override
  void initState() {
    super.initState();
    controller.initState();
    widget.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _shouldUpdate = true;
    });

    _unmountFunction = controllerXviewStream.watch(controller, _updateState);
  }

  @protected
  @override
  void dispose() {
    widget.dispose();
    _unmountFunction?.call();
    _shouldUpdate = false;
    super.dispose();
  }

  @override
  Widget build(_) => widget.build(controller);
}
