
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import "../../extension/themedata_extension.dart";

/// Fonts specially produced by the developer are defined in this class. 
/// Thanks to [AppFontsExtension] extension overwritten [ThemeData], it can be accessed by this class and its contents.
class AppFonts{
  static  AppFonts? _instance =  AppFonts._init();
  static AppFonts get instance {
    _instance ??= AppFonts._init();
    return _instance!;
  }

  AppFonts._init();

  Color get textStyleBlackColor => const Color.fromRGBO(48, 44, 45, 1);
  Color get textStyleGreyColor => const Color.fromRGBO(114, 114, 122, 1);

  TextStyle get appbarTitleStyle => GoogleFonts.poppins(
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: 1,
    color: const Color.fromRGBO(24,23,24,1),
  );

  TextStyle get bigTitle => GoogleFonts.poppins(
    fontWeight: FontWeight.w500,
    fontSize: 24,
    color: textStyleBlackColor
  );

  TextStyle get onboardContent => GoogleFonts.poppins(
    fontWeight: FontWeight.w300,
    fontSize: 16,
    color: textStyleGreyColor,
  );
  TextStyle get onboardSubtitle => GoogleFonts.poppins(
    fontWeight: FontWeight.w300,
    fontSize: 16,
    color: textStyleGreyColor,
  );

  TextStyle get textFieldHintStyle => GoogleFonts.poppins(
    fontWeight: FontWeight.w300,
    fontSize: 15,
    color: textStyleGreyColor
  );

  TextStyle get subContent => GoogleFonts.poppins(
    fontWeight: FontWeight.w300,
    fontSize: 11,
    color: textStyleGreyColor
  );

  TextStyle get title1 => GoogleFonts.poppins(
    fontWeight: FontWeight.w400,
    fontSize: 15,
    color: textStyleBlackColor
  );
  TextStyle get title2 => GoogleFonts.poppins(
    fontWeight: FontWeight.w500,
    fontSize: 14,
    color: textStyleBlackColor
  );

  TextStyle get title3 => GoogleFonts.poppins(
    fontWeight: FontWeight.w400,
    fontSize: 15,
    letterSpacing: 1,
    color: textStyleBlackColor
  );

  TextStyle get tabTitle1 => GoogleFonts.poppins(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 1,
    color: textStyleBlackColor
  );

  TextStyle get subTitle1 => GoogleFonts.poppins(
    fontWeight: FontWeight.w400,
    fontSize: 15,
    color: textStyleGreyColor
  );

  TextStyle get subTitle2 => GoogleFonts.poppins(
    fontWeight: FontWeight.w300,
    fontSize: 12,
    color: textStyleGreyColor
  );
  TextStyle get subTitle2Black => GoogleFonts.poppins(
    fontWeight: FontWeight.w300,
    fontSize: 12,
    color: textStyleBlackColor
  );
  TextStyle get informationTextStyle => GoogleFonts.poppins(
    fontWeight: FontWeight.w300,
    fontSize: 13,
    color: textStyleGreyColor,
  );
  TextStyle get subTitleLower => GoogleFonts.poppins(
    fontWeight: FontWeight.w400,
    fontSize: 11,
    color: textStyleGreyColor
  );
  TextStyle get subTitleExtraLow => GoogleFonts.poppins(
    fontWeight: FontWeight.w400,
    fontSize: 10,
    letterSpacing: 1,
    color: textStyleBlackColor
  );

  TextStyle get cardSubTitleLocation => GoogleFonts.poppins(
    fontWeight: FontWeight.w300,
    fontSize: 14,
    color: textStyleGreyColor
  );

  TextStyle get cardTitle => GoogleFonts.poppins(
    fontWeight: FontWeight.w500,
    fontSize: 15,
    color: textStyleBlackColor
  );

  TextStyle get amountStyle => GoogleFonts.poppins(
    fontWeight: FontWeight.w500,
    fontSize: 16,
    color: textStyleBlackColor
  );

  TextStyle get cardSubTitleTime => GoogleFonts.poppins(
    fontWeight: FontWeight.w300,
    fontSize: 12,
    color: textStyleGreyColor
  );
  TextStyle get contentTitle => GoogleFonts.poppins(
    fontWeight: FontWeight.w600,
    fontSize: 16,
    letterSpacing: 1,
    color: textStyleBlackColor
  );

  TextStyle get contentParagraph => GoogleFonts.poppins(
    fontWeight: FontWeight.w300,
    fontSize: 12,
    letterSpacing: 1,
    color: textStyleGreyColor
  );

  TextStyle get categoryStyle => GoogleFonts.poppins(
    fontWeight: FontWeight.w300,
    fontSize: 11,
    letterSpacing: 1,
  );

  TextStyle get serviceTitle => GoogleFonts.poppins(
    fontWeight: FontWeight.w500,
    fontSize: 14,
    letterSpacing: 1,
    color: textStyleBlackColor
  );

  TextStyle get servicesubTitle => GoogleFonts.poppins(
    fontWeight: FontWeight.w400,
    fontSize: 12,
    letterSpacing: 1,
    color: textStyleGreyColor
  );

  TextStyle get notificationTileTitleStyle => GoogleFonts.poppins(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: textStyleBlackColor
  );
  TextStyle get totalTitleStyle => GoogleFonts.poppins(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: textStyleGreyColor
  );

  TextStyle get scoreSubStyle => GoogleFonts.poppins(
    fontWeight: FontWeight.w300,
    fontSize: 14,
    letterSpacing: .2,
    color: textStyleGreyColor
  );

  TextStyle get settingsTitleStyle => GoogleFonts.poppins(
    fontWeight: FontWeight.w300,
    fontSize: 14,
    letterSpacing: .8,
    color: textStyleBlackColor
  );

  TextStyle get settingsTitleStyleWithoutLetterSpacing => GoogleFonts.poppins(
    fontWeight: FontWeight.w300,
    fontSize: 14,
    color: textStyleBlackColor
  );

  TextStyle get settingsSubtitleStyle => GoogleFonts.poppins(
    fontWeight: FontWeight.w300,
    fontSize: 12,
    letterSpacing: .8,
    color: textStyleGreyColor
  );

  TextStyle get elevatedButtonTextStyle => GoogleFonts.poppins(
    fontWeight: FontWeight.w600,
    fontSize: 15,
  );
  TextStyle get profileTitleStyle => GoogleFonts.poppins(
    fontWeight: FontWeight.w500,
    fontSize: 20,
    letterSpacing: .75,
    color: textStyleGreyColor,
  );
  TextStyle get tabbarTitle => GoogleFonts.poppins(
    fontWeight: FontWeight.w500,
    fontSize: 12,
    letterSpacing: 1,
    color: textStyleGreyColor,
  );
  TextStyle get dateHeaderTitleStyle => GoogleFonts.poppins(
    fontWeight: FontWeight.w400,
    fontSize: 18,
    letterSpacing: 1,
    color: textStyleBlackColor,
  );
  TextStyle get dateDayTitleStyle => GoogleFonts.poppins(
    fontWeight: FontWeight.w400,
    fontSize: 15,
    letterSpacing: 1,
    color: textStyleGreyColor,
  );
  TextStyle get dateHourStyle => GoogleFonts.poppins(
    fontWeight: FontWeight.w400,
    fontSize: 13,
    letterSpacing: .6,
    color: textStyleGreyColor,
  );
  TextStyle get successMessageStyle => GoogleFonts.poppins(
    fontWeight: FontWeight.w500,
    fontSize: 18,
    letterSpacing: .6,
    color: Colors.white,
  );

  TextStyle get paymentButtonTextStyle => GoogleFonts.poppins(
    fontWeight: FontWeight.w600,
    fontSize: 12,
    letterSpacing: 1,
    color: Colors.white
  );
  TextStyle get paymentAddMethodButtonStyle => GoogleFonts.poppins(
    fontWeight: FontWeight.w400,
    fontSize: 10,
    letterSpacing: -0.63,
    color: Colors.black
  );
  TextStyle get profileSettingsTopTitleStyle => GoogleFonts.poppins(
    fontWeight: FontWeight.w400,
    fontSize: 20,
    letterSpacing: .8,
    color: Colors.black
  );
  TextStyle get profileVersionStyle => GoogleFonts.poppins(
    fontWeight: FontWeight.w300,
    fontSize: 10,
    letterSpacing: .8,
    color: textStyleGreyColor
  );
}