extension StringExtensions on String {
  /// It capitalizes your string.
  String get capitalize => this[0].toUpperCase() + substring(1);
}
