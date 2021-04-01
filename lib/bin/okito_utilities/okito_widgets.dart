import 'package:flutter/material.dart';

final flutterDialog = showDialog;

mixin OkitoWidgets {
  BuildContext? get context;

  /// Shows a [SnackBar] across all registered [Scaffold]s.
  void showSnackBar({required SnackBar snackBar}) {
    if (context != null) {
      ScaffoldMessenger.of(context!).showSnackBar(snackBar);
    }
  }

  /// Displays a Material dialog above the current contents of the app,
  /// with Material entrance and exit animations, modal barrier color, and
  ///  modal barrier behavior (dialog is dismissible with a tap on the barrier).
  void showDialog({required Widget child}) {
    if (context != null) {
      flutterDialog(context: context!, builder: (ctx) => child);
    }
  }

  /// Shows a modal material design bottom sheet.
  void showModal({
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
  }) {
    if (context != null) {
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
  }
}
