
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:weather_app/core/extension/context_extension.dart';
import 'package:weather_app/core/extension/themedata_extension.dart';
import 'package:weather_app/view/weather_of_week/model/single_day_weather_model.dart';

class WeatherOfDayTile extends StatelessWidget {
  final SingleDayWeatherModel singleDayWeatherModel;
  final void Function() onPressed;
  const WeatherOfDayTile({
    Key? key,
    required this.singleDayWeatherModel,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onPressed,
          child: Padding(
            padding: context.paddingNormalVertical + context.paddingMediumHorizontal * .7,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // day
                SizedBox(
                  width: context.getDynamicWidth(18),
                  child: Text(singleDayWeatherModel.day, style: context.currentThemeData.currentAppFonts.servicesubTitle.copyWith(color: Colors.white))),
                // weather icon
                CachedNetworkImage(
                  imageUrl: singleDayWeatherModel.iconUrl,
                  width: context.getDynamicWidth(6),
                ),
                // degrees
                Row(
                  // degree
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: context.lowValue),
                      child: SizedBox(
                        width: context.getDynamicWidth(7),  
                        child: Text("${singleDayWeatherModel.degree} \u00b0", style: context.currentThemeData.currentAppFonts.title1.copyWith(color: context.currentThemeData.canvasColor))
                      ),
                    ),
                    // night degree
                    SizedBox(
                      width: context.getDynamicWidth(7),  
                      child: Text("${singleDayWeatherModel.degreeOnNight} \u00b0", style: context.currentThemeData.currentAppFonts.title1.copyWith(color: context.currentThemeData.canvasColor))
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        // divider
        Divider(
          color: Colors.white,
          indent: context.normalValue,
          endIndent: context.normalValue,
          height: 1,
          thickness: 1,
        ),
      ],
    );  
  }
}
