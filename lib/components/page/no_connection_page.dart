
import 'package:flutter/material.dart';
import 'package:weather_app/core/extension/context_extension.dart';
import 'package:weather_app/core/extension/string_extension.dart';
import 'package:weather_app/core/extension/themedata_extension.dart';
import 'package:weather_app/core/init/language/locale_keys.g.dart';

class NoConnectionPage extends StatelessWidget {
  const NoConnectionPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.wifi_off, size: 42, color: context.currentThemeData.colorScheme.error),
            Padding(
              padding: EdgeInsets.only(top: context.normalValue),
              child: Text(LocaleKeys.notConnectionError.locale, style: context.currentThemeData.currentAppFonts.tabTitle1),
            ),
          ],
        ),
      ),
    );
  }
}