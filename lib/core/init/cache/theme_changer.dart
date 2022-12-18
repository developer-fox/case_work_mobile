
import 'package:flutter/material.dart';
import '../../constants/enums/app_themes_enum.dart';
import '../theme/app_theme_light.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeData _currentTheme = AppThemeLight.instance.theme;
  AppThemes _currenThemeEnum = AppThemes.appThemeLight;

  /// Applicaton theme enum.
  /// Deafult value is [AppThemes.LIGHT]
  AppThemes get currenThemeEnum => _currenThemeEnum;
  ThemeData get currentTheme => _currentTheme;

  void changeValue(AppThemes theme) {
    if (theme == AppThemes.appThemeLight) {
      _currentTheme = ThemeData.light();
    } else {
      _currentTheme = ThemeData.dark();
    }
    notifyListeners();
  }

  /// Change your app theme with [currenThemeEnum] value.
  void changeTheme() {
    if (_currenThemeEnum == AppThemes.appThemeLight) {
      _currentTheme = ThemeData.dark();
      _currenThemeEnum = AppThemes.appThemeDark;
    } else {
      _currentTheme = AppThemeLight.instance.theme;
      _currenThemeEnum = AppThemes.appThemeLight;
    }
    notifyListeners();
  }
}