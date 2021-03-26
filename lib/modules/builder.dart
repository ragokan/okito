import 'package:flutter/material.dart';

import '../types/callback_types.dart';
import 'communication.dart';
import 'controller.dart';

class OkitoBuilder<T extends OkitoController> extends StatefulWidget {
  final ControllerCallback callback;
  final T controller;
  OkitoBuilder({
    Key? key,
    required this.callback,
    required this.controller,
  }) : super(key: key);

  @override
  _OkitoBuilderState createState() => _OkitoBuilderState();
}

class _OkitoBuilderState extends State<OkitoBuilder> {
  @override
  void initState() {
    super.initState();
    communication.watch(widget.controller, () => setState(() {}));
  }

  @override
  Widget build(_) => widget.callback();
}
