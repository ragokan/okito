import '../../../okito.dart';

/// Uses your locale and translates the sentences.
///
/// Usage
///
/// ```dart
/// localizeSimple('hello');
/// ```
/// That simple
///
/// Check translation documents for this.
String localizeSimple(String key) {
  if (Okito.app.locale == null) return key;
  final _languageTranslations = Okito
          .app.translations[Okito.app.locale.toString()] ??
      Okito.app.translations[Okito.app.locale?.languageCode.toString()] ??
      Okito.app.translations[Okito.app.fallbackLocale.toString()] ??
      Okito.app.translations[Okito.app.fallbackLocale.languageCode.toString()];

  final _translate =
      _languageTranslations != null ? _languageTranslations[key] ?? key : key;
  return _translate;
}
