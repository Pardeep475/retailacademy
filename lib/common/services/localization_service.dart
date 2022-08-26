// import 'dart:ui';
//
// import 'package:get/get.dart';
//
// import '../app_strings.dart';
// import '../lang/de_de.dart';
// import '../lang/en_us.dart';
//
// class LocalizationService extends Translations {
//   // Default locale
//   static const locale =  Locale('en', 'US');
//
//   // fallbackLocale saves the day when the locale gets in trouble
//   static const fallbackLocale = Locale('de', 'De');
//
//   // Supported languages
//   // Needs to be same order with locales
//   static final langs = [AppStrings.english, AppStrings.german];
//
//   // Supported locales
//   // Needs to be same order with langs en_US  de_CH de_DE
//   static final locales = [const Locale('en', 'US'), const Locale('de', 'DE'), const Locale('de', 'CH')];
//
//   // Keys and their translations
//   // Translations are separated maps in `lang` file
//   @override
//   Map<String, Map<String, String>> get keys => {
//         'en_US': enUS, // lang/en_us.dart
//         'de_DE': deDE, // lang/de_de.dart
//         'de_CH': deDE, // lang/de_de.dart
//       };
//
//   // Gets locale from language, and updates the locale
//   void changeLocale(String lang) {
//     final locale = _getLocaleFromLanguage(lang);
//     Get.updateLocale(locale!);
//   }
//
//   // Finds language in `langs` list and returns it as Locale
//   Locale? _getLocaleFromLanguage(String lang) {
//     for (int i = 0; i < langs.length; i++) {
//       if (lang == langs[i]) return locales[i];
//     }
//     return locales[0];
//     // return Get.locale;
//   }
// }
