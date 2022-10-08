import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';

class AppLocalizations {
  final Locale? locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _ApplicationLocalizationDelegate();

  Map<String, String>? localizedStrings;

  Future<bool> load() async {
    String jsonString = await rootBundle.loadString(
        'lib/assets/languages/${locale?.languageCode}_${locale?.countryCode}.json');
    print("sdadsasa---$jsonString");
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });
    return true;
  }

  String translate(String key) {
    print(localizedStrings?[key] ?? key);
    return localizedStrings?[key] ?? key;
  }
}

class _ApplicationLocalizationDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _ApplicationLocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    return AppConstant.supportedLanguages.contains(locale);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_ApplicationLocalizationDelegate old) => false;
}
