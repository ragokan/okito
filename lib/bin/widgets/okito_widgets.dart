import 'package:flutter/material.dart';

import '../extensions/okito_extensions.dart';

mixin OkitoWidgets {
  late BuildContext context;

  /// Shows a [SnackBar] across all registered [Scaffold]s.
  void showSnackbar({required SnackBar snackBar}) =>
      context.showSnackBar(snackBar: snackBar);

  /// Displays a Material dialog above the current contents of the app,
  /// with Material entrance and exit animations, modal barrier color, and
  ///  modal barrier behavior (dialog is dismissible with a tap on the barrier).
  void showDialog({required Widget child}) => context.showDialog(child: child);

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
    context.showModal(
      child: child,
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
