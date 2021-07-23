import 'package:flutter/material.dart';
import '../../okito.dart';

/// Regular callback type for the whole library.
typedef VoidCallback = void Function();

/// Regular future callback type for the whole library.
typedef FutureVoidCallback = Future<void> Function();

/// A callback that returns Widget.
/// It is current used only for OkitoBuilder.
typedef BuilderCallback = Widget Function();

/// It is used for OkitoWatcher right now,
/// Returns a void function that gives the [controller] with type [T].
typedef WatcherCallback<T extends OkitoController> = void Function(
    T controller);

/// It is used for Rockitos right now,
/// Returns a void function that gives the [controller] with type [T].
typedef ControllerCallback<T extends OkitoController> = Widget Function(
    T controller);

/// We use this only for filtering Builders.
typedef FilterCallback<T extends OkitoController> = Object? Function(
    T controller);
