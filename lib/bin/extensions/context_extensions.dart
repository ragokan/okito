import 'package:flutter/material.dart';

final flutterDialog = showDialog;

extension BuildContextExtensions on BuildContext {
  /// The horizontal extent of this size.
  double get width => MediaQuery.of(this).size.width;

  /// The vertical extent of this size.
  double get height => MediaQuery.of(this).size.height;

  /// The aspect ratio of this size.
  ///
  ///This returns the [width] divided by the [height].
  double get aspectRatio => MediaQuery.of(this).size.aspectRatio;

  /// The number of device pixels for each logical pixel. This number might not
  ///  be a power of two. Indeed, it might not even be an integer. For example,
  ///  the Nexus 6 has a device pixel ratio of 3.5.
  double get devicePixelRatio => MediaQuery.of(this).devicePixelRatio;

  /// Whether device is wider than tall or not.
  bool get isLandscape =>
      MediaQuery.of(this).orientation == Orientation.landscape;

  /// Whether device is taller than wide or not.
  bool get isPortrait =>
      MediaQuery.of(this).orientation == Orientation.portrait;

  /// App theme.
  ThemeData get theme => Theme.of(this);

  /// Shows a [SnackBar] across all registered [Scaffold]s.
  void showSnackBar({required SnackBar snackBar}) {
    ScaffoldMessenger.of(this).showSnackBar(snackBar);
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

  /// Displays a Material dialog above the current contents of the app,
  /// with Material entrance and exit animations, modal barrier color, and
  ///  modal barrier behavior (dialog is dismissible with a tap on the barrier).
  void showDialog({required Widget child}) {
    flutterDialog(context: this, builder: (ctx) => child);
  }

  /// Push the given route onto the navigator that most
  /// tightly encloses the given context.
  void push({required Widget page, required RouteSettings settings}) =>
      Navigator.push(
        this,
        MaterialPageRoute(
          builder: (_) => page,
          settings: settings,
        ),
      );

  /// Replace the current route of the navigator that most tightly encloses the
  ///  given context by pushing the given route and then disposing the previous
  ///  route once the new route has finished animating in.
  void pushReplacement(
          {required Widget page, required RouteSettings settings}) =>
      Navigator.pushReplacement(
        this,
        MaterialPageRoute(
          builder: (_) => page,
          settings: settings,
        ),
      );

  /// Push a named route onto the navigator that most
  ///  tightly encloses the given context.
  void pushNamed({required String routeName, Object? arguments}) =>
      Navigator.pushNamed(this, routeName, arguments: arguments);

  /// Replace the current route of the navigator that most tightly encloses
  ///  the given context by pushing the route named [routeName] and then
  ///  disposing the previous route once the new route has finished
  /// animating in.
  void pushReplacementNamed({required String routeName, Object? arguments}) =>
      Navigator.pushReplacementNamed(this, routeName, arguments: arguments);

  /// Pop the top-most route off the navigator that
  ///  most tightly encloses the given context.
  void pop({Object? result}) => Navigator.pop(this, result);

  /// The arguments passed to this route.
  Object? get arguments => ModalRoute.of(this)?.settings.arguments;

  /// The name of the route (e.g., "/settings").
  String? get routeName => ModalRoute.of(this)?.settings.name;
}
