import 'package:flutter/material.dart';

/// Because the function we are going to use is [showDialog] from flutter and
/// [Okito.showDialog()], we get problems. I renamed this variable here to
/// prevent name confusions.
const _showDialog = showDialog;

/// The way to use widgets like *snackbar* or *bottom modal sheet* without
/// context, we have this mixin. We have to override the [context] in Okito.
mixin OkitoWidgets {
  /// The [BuildContext]:[context] of your app.
  BuildContext? get context;

  /// Shows a [SnackBar] across all registered [Scaffold]s but instead of
  /// [SnackBar] widget, you can just give it a string.
  void showToast({
    required String text,
    Duration? duration,
    SnackBarAction? action,
    TextStyle? textStyle,
    Color? backgroundColor,
    bool hideCurrentSnackbar = true,
  }) {
    if (hideCurrentSnackbar) {
      ScaffoldMessenger.of(context!).hideCurrentSnackBar();
    }
    ScaffoldMessenger.of(context!).showSnackBar(
      SnackBar(
        content: Text(
          text,
          style: textStyle,
        ),
        backgroundColor: backgroundColor,
        duration: duration ?? const Duration(seconds: 5),
        action: action,
      ),
    );
  }

  /// Shows a [SnackBar] across all registered [Scaffold]s.
  void showSnackBar({
    required SnackBar snackBar,
    bool hideCurrentSnackbar = true,
  }) {
    if (hideCurrentSnackbar) {
      ScaffoldMessenger.of(context!).hideCurrentSnackBar();
    }
    ScaffoldMessenger.of(context!).showSnackBar(snackBar);
  }

  /// Displays a Material dialog above the current contents of the app,
  /// with Material entrance and exit animations, modal barrier color, and
  ///  modal barrier behavior (dialog is dismissible with a tap on the barrier).
  Future<T?> showDialog<T>({
    required Widget child,
    bool barrierDismissible = true,
    Color? barrierColor = Colors.black54,
    String? barrierLabel,
    bool useSafeArea = true,
    bool useRootNavigator = true,
    RouteSettings? routeSettings,
  }) async =>
      _showDialog(
        context: context!,
        builder: (_) => child,
        barrierColor: barrierColor,
        barrierDismissible: barrierDismissible,
        barrierLabel: barrierLabel,
        routeSettings: routeSettings,
        useRootNavigator: useRootNavigator,
        useSafeArea: useSafeArea,
      );

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
