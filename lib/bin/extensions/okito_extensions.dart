import 'package:flutter/material.dart';

final flutterDialog = showDialog;

extension BuildContextUtilities on BuildContext {
  double get width => MediaQuery.of(this).size.width;

  double get height => MediaQuery.of(this).size.height;

  double get aspectRatio => MediaQuery.of(this).size.aspectRatio;

  double get devicePixelRatio => MediaQuery.of(this).devicePixelRatio;

  bool get isLandscape =>
      MediaQuery.of(this).orientation == Orientation.landscape;

  bool get isPortrait =>
      MediaQuery.of(this).orientation == Orientation.portrait;

  void showSnackBar({required SnackBar snackBar}) {
    ScaffoldMessenger.of(this).showSnackBar(snackBar);
  }

  ThemeData get theme => Theme.of(this);

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
  }) =>
      showModalBottomSheet(
        context: this,
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

  void showDialog({required Widget child}) {
    flutterDialog(context: this, builder: (ctx) => child);
  }

  void push({required Widget page, required RouteSettings settings}) =>
      Navigator.push(
        this,
        MaterialPageRoute(
          builder: (_) => page,
          settings: settings,
        ),
      );

  void pushReplacement(
          {required Widget page, required RouteSettings settings}) =>
      Navigator.pushReplacement(
        this,
        MaterialPageRoute(
          builder: (_) => page,
          settings: settings,
        ),
      );

  void pushNamed({required String routeName, Object? arguments}) =>
      Navigator.pushNamed(this, routeName, arguments: arguments);

  void pushReplacementNamed({required String routeName, Object? arguments}) =>
      Navigator.pushReplacementNamed(this, routeName, arguments: arguments);

  void pop({Object? result}) => Navigator.pop(this, result);

  Object? get arguments => ModalRoute.of(this)?.settings.arguments;
  String? get routeName => ModalRoute.of(this)?.settings.name;
}
