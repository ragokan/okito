extension StringExtensions on String {
  /// It capitalizes your string.
  String get capitalize => this[0].toUpperCase() + substring(1);

  /// Parses your string and returns an integer.
  int toInt() => int.parse(this);

  /// Parses your string and returns a double.
  double toDouble() => double.parse(this);

  /// Parses your string and returns a number.
  num toNumber() => num.parse(this);
}
