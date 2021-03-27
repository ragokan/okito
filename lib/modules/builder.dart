import 'package:flutter/material.dart';

import '../types/callback_types.dart';
import 'communication.dart';
import 'controller.dart';

class OkitoBuilder<T extends OkitoController> extends StatefulWidget {
  final ControllerCallback builder;
  final T controller;
  final List<T> otherControllers;
  OkitoBuilder({
    Key? key,
    required this.builder,
    required this.controller,
    this.otherControllers = const [],
  }) : super(key: key);

  @override
  _OkitoBuilderState createState() => _OkitoBuilderState();
}

class _OkitoBuilderState extends State<OkitoBuilder> {
  @override
  void initState() {
    super.initState();

    communication.watch(widget.controller, () => setState(() {}));

    widget.otherControllers.forEach((controller) {
      communication.watch(controller, () => setState(() {}));
    });
  }

  @override
  Widget build(_) => widget.builder();
}
