import 'package:flutter/material.dart';

mixin OkitoWidgets {
  BuildContext? context;

  void showSnackbar({required SnackBar snackBar}) {
    ScaffoldMessenger.of(context!).showSnackBar(snackBar);
  }

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
