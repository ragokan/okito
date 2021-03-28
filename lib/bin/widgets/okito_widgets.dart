import 'package:flutter/material.dart';

import '../extensions/okito_extensions.dart';

mixin OkitoWidgets {
  late BuildContext context;

  void showSnackbar({required SnackBar snackBar}) =>
      context.showSnackBar(snackBar: snackBar);

  void showDialog({required Widget child}) => context.showDialog(child: child);

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
