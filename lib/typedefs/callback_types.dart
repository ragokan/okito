import 'package:flutter/material.dart';

/// Regular callback type for the whole library.
typedef VoidCallback = void Function();

/// A callback that returns Widget.
/// It is current used only for OkitoBuilder.
typedef BuilderCallback = Widget Function();

/// It is used for OkitoWatcher right now,
/// Returns a void function that gives the [controller] with type [T].
typedef WatcherCallback<T> = void Function(T controller);
