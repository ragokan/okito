import 'package:flutter/material.dart';

import '../modules/communication.dart';
import '../types/callback_types.dart';
import 'controller.dart';

class OkitoBuilder<T extends OkitoController> extends StatefulWidget {
  final T controller;
  final List<T> otherControllers;
  final ControllerCallback builder;
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

  @override
  void initState() {
    super.initState();

    final unmount =
        communication.watch(widget.controller, () => setState(() {}));
    unmountFunctions.add(unmount);

    widget.otherControllers.forEach((controller) {
      final unmount = communication.watch(controller, () => setState(() {}));
      unmountFunctions.add(unmount);
    });
  }

  @override
  void dispose() {
    super.dispose();
    unmountFunctions.forEach((unmount) => unmount());
  }

  @override
  Widget build(_) => widget.builder();
}
