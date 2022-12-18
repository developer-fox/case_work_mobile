
import 'package:flutter/material.dart';
import '../init/theme/app_fonts.dart';

extension AppFontsExtension on ThemeData{
  /// Makes the custom font information defined by the developer accessible via ThemeData objects.
  AppFonts get currentAppFonts =>  AppFonts.instance;
}