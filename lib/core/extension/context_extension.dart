
import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  // Returns information about the screen
  MediaQueryData get mediaQuery => MediaQuery.of(this);
}

extension ThemeExtension on BuildContext {
  // Returns the current theme information.
  ThemeData get currentThemeData => Theme.of(this);
}

extension MediaQueryExtension on BuildContext {
  // returns the screen height
  double get height => mediaQuery.size.height;
  // returns the screen width
  double get width => mediaQuery.size.width;
  // several different flexible values are defined in this way according to the screen height.
  double get lowValue => height * 0.012;
  double get normalValue => height * 0.02;
  double get mediumValue => height * 0.04;
  double get highValue => height * 0.07;
  double get hugeValue => height * 0.1;
}

extension MediaQueryExtensionDynamic on BuildContext {
  /// Thanks to [getDynamicHeight], we can get values according to the screen width.
  double getDynamicHeight(double percent) => height*(percent/100);
  /// Thanks to [getDynamicWidth], we can get values according to the screen width.
  double getDynamicWidth(double percent) => width*(percent/100);
}

// paddings defined based on flex values defined above
extension PaddingExtensionAll on BuildContext {
  EdgeInsets get paddingLow => EdgeInsets.all(lowValue);
  EdgeInsets get paddingNormal => EdgeInsets.all(normalValue);
  EdgeInsets get paddingMedium => EdgeInsets.all(mediumValue);
  EdgeInsets get paddingHigh => EdgeInsets.all(highValue);
  EdgeInsets get paddingHuge => EdgeInsets.all(hugeValue);
}

//
extension PaddingExtensionSymetric on BuildContext {
  EdgeInsets get paddingLowVertical => EdgeInsets.symmetric(vertical: lowValue);
  EdgeInsets get paddingNormalVertical =>
      EdgeInsets.symmetric(vertical: normalValue);
  EdgeInsets get paddingMediumVertical =>
      EdgeInsets.symmetric(vertical: mediumValue);
  EdgeInsets get paddingHighVertical =>
      EdgeInsets.symmetric(vertical: highValue);
  EdgeInsets get paddingHugeVertical =>
      EdgeInsets.symmetric(vertical: hugeValue);

  EdgeInsets get paddingLowHorizontal =>
      EdgeInsets.symmetric(horizontal: lowValue);
  EdgeInsets get paddingNormalHorizontal =>
      EdgeInsets.symmetric(horizontal: normalValue);
  EdgeInsets get paddingMediumHorizontal =>
      EdgeInsets.symmetric(horizontal: mediumValue);
  EdgeInsets get paddingHighHorizontal =>
      EdgeInsets.symmetric(horizontal: highValue);
  EdgeInsets get paddingHugeHorizontal =>
      EdgeInsets.symmetric(horizontal: hugeValue);
}

extension DurationExtension on BuildContext {
  Duration get lowDuration => const Duration(milliseconds: 500);
  Duration get normalDuration => const  Duration(seconds: 1);
}