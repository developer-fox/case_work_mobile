
import 'package:flutter/material.dart';

/// The [LanguageManager] class makes language-dependent content operations more efficient and manageable over a single instance.
/// 
/// The local keys.g.dart file needs to be regenerated when data is added to the language pack.
/// The script below does this automatically.
//? flutter pub run easy_localization:generate  -O lib/core/init/language -f keys -o locale_keys.g.dart -S asset/language
// 
class LanguageManager{
  static LanguageManager? _instance =  LanguageManager._init();
  static LanguageManager get instance {
    _instance ??= LanguageManager._init();
    return _instance!;
  }

  LanguageManager._init();

  final enLocale = const Locale('en', 'US');
  final trLocale = const Locale('tr', 'TR');
  List<Locale> get supportedLocales => [enLocale, trLocale];
}