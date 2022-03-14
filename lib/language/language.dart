import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class AppLocalizations
{

  Map<String, dynamic> _localizedStrings;
  final Locale locale;
  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  static String languageCode = null;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context)
  {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  Future<bool> load() async
  {
    String fileContent = await rootBundle.loadString("assets/lang/lang.json");

    _localizedStrings = json.decode(fileContent);

    return true;
  }

  String get(String string){

    return _localizedStrings[string][languageCode == null ? locale.languageCode : languageCode];
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations>
{
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'it', 'pl', 'de', 'fr', 'es'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async
  {
    AppLocalizations localizations = new AppLocalizations(locale);

    await localizations.load();

    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}