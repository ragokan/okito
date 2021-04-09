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
  final languageTranslations = Okito
          .app.translations[Okito.app.locale.toString()] ??
      Okito.app.translations[Okito.app.locale?.languageCode.toString()] ??
      Okito.app.translations[Okito.app.fallbackLocale.toString()] ??
      Okito.app.translations[Okito.app.fallbackLocale.languageCode.toString()];
  final translate =
      languageTranslations != null ? languageTranslations[key] ?? key : key;
  return translate;
}
