
import 'package:flutter/material.dart';

/// [BaseState] is an intermediate state class. Thanks to this class, we can add additional features to our states and manage all states from one place.
abstract class BaseState<T extends StatefulWidget> extends State<T>{
  /// [currentThemeData] returns the current theme information.
  ThemeData get currentThemeData => Theme.of(context);
  //
  /// Thanks to [getDynamicHeight], we can get values according to the screen width.
  double getDynamicHeight(double percent) => MediaQuery.of(context).size.height *(percent/100);
  //
  /// Thanks to [getDynamicWidth], we can get values according to the screen width.
  double getDynamicWidth(double percent) => MediaQuery.of(context).size.width *(percent/100);
}