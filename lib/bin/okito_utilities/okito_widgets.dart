import 'package:flutter/material.dart';

final flutterDialog = showDialog;

mixin OkitoWidgets {
  BuildContext? get context;

  /// Shows a [SnackBar] across all registered [Scaffold]s.
  void showToast(
      {required String content, Duration? duration, SnackBarAction? action}) {
    ScaffoldMessenger.of(context!).showSnackBar(
      SnackBar(
        content: Text(content),
        duration: duration ?? const Duration(seconds: 5),
        action: action,
      ),
    );
  }

  /// Shows a [SnackBar] across all registered [Scaffold]s.
  void showSnackBar({required SnackBar snackBar}) {
    ScaffoldMessenger.of(context!).showSnackBar(snackBar);
  }

  /// Displays a Material dialog above the current contents of the app,
  /// with Material entrance and exit animations, modal barrier color, and
  ///  modal barrier behavior (dialog is dismissible with a tap on the barrier).
  Future<T?> showDialog<T>({required Widget child}) async =>
      flutterDialog(context: context!, builder: (ctx) => child);

  /// Shows a modal material design bottom sheet.
  Future<T?> showModal<T>({
    required Widget child,
    Color? backgroundColor,
    Color? barrierColor,
    Clip? clipBehavior,
    double? elevation,
    bool enableDrag = false,
    bool isDismissible = true,
    bool isScrollControlled = false,
    RouteSettings? routeSettings,
    ShapeBorder? shape,
    AnimationController? transitionAnimationController,
    bool useRootNavigator = false,
  }) async =>
      showModalBottomSheet(
        context: context!,
        builder: (_) => child,
        backgroundColor: backgroundColor,
        barrierColor: barrierColor,
        clipBehavior: clipBehavior,
        elevation: elevation,
        enableDrag: enableDrag,
        isDismissible: isDismissible,
        isScrollControlled: isScrollControlled,
        routeSettings: routeSettings,
        shape: shape,
        transitionAnimationController: transitionAnimationController,
        useRootNavigator: useRootNavigator,
      );
}
