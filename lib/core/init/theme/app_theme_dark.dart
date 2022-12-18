
import 'package:flutter/material.dart';

//? AppThemeLight.instance.<method_name> 
class AppThemeDark{

  static AppThemeDark? _instance =  AppThemeDark._init();
  static AppThemeDark get instance {
    _instance ??= AppThemeDark._init();
    return _instance!;
  }

  AppThemeDark._init();

  // uygulamada kullanilacak renkler bu sekilde belirtilmistirç
  //? AppThemeLight.instance.theme.ColorScheme.<attribute_name>
  ThemeData get theme => ThemeData(

    canvasColor: Colors.red,

    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Colors.blue,
      onPrimary: Colors.white, 
      secondary: Colors.pink, 
      onSecondary: Colors.yellow,
      error: Colors.red, 
      onError: Colors.black, 
      background: Colors.grey, 
      onBackground: Colors.black, 
      surface: Colors.lightGreen,
      onSurface: Colors.orange)
  );



}

