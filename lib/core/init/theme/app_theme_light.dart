
import 'package:flutter/material.dart';

import 'app_fonts.dart';

//? AppThemeLight.instance.<method_name> 
class AppThemeLight{

  static AppThemeLight? _instance =  AppThemeLight._init();
  static AppThemeLight get instance {
    _instance ??= AppThemeLight._init();
    return _instance!;
  }

  AppThemeLight._init();

  // uygulamada kullanilacak renkler bu sekilde belirtilmistirç
  //? AppThemeLight.instance.theme.ColorScheme.<attribute_name>
  ThemeData get theme => ThemeData(
    canvasColor: Colors.white,
    primaryColorLight: const Color.fromARGB(255, 230, 230, 230),
    colorScheme:  ColorScheme(
      brightness: Brightness.light,
      primary:  const Color.fromRGBO(57, 36, 106, 1),
      onPrimary: Colors.white, 
      secondary: const Color.fromRGBO(52, 234, 216, 1), 
      onSecondary: Colors.white,
      error: Colors.red, 
      onError: Colors.black, 
      background: Colors.grey, 
      onBackground: Colors.black, 
      surface: Colors.lightGreen,
      onSurface: Colors.grey.shade900),
    scrollbarTheme: ScrollbarThemeData(
      interactive: true,
      thickness: MaterialStateProperty.all(4),
      thumbVisibility: MaterialStateProperty.all(true),
      thumbColor: MaterialStateProperty.all(const Color.fromRGBO(217, 217, 217, 1)),
    ),

    appBarTheme: AppBarTheme(
      titleTextStyle: AppFonts.instance.appbarTitleStyle,
      elevation: .5,
      centerTitle: true,
      iconTheme: const IconThemeData(
        color: Color.fromRGBO(0, 0, 0, .7)
      ),
      color:  Colors.white,
      shadowColor: const Color.fromRGBO(236, 236, 236, 1),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
      )
    ),
  );
}

