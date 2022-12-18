

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:weather_app/core/extension/context_extension.dart';
import 'package:weather_app/core/extension/themedata_extension.dart';
import 'package:weather_app/view/weather_of_week/model/single_day_weather_model.dart';

class WeatherOfDayPanel extends StatelessWidget {
  final SingleDayWeatherModel? weatherModel;
  final Color colorData;
  const WeatherOfDayPanel({
    Key? key,
    this.weatherModel,
    required this.colorData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final weatherOfToday = weatherModel!;
    return Column(
      children: [
        // city 
        Padding(
          padding: context.paddingNormalVertical,
          child: Text(weatherOfToday.day, style: context.currentThemeData.currentAppFonts.cardTitle.copyWith(color: colorData)),
        ),
        // weather icon
        CachedNetworkImage(
          imageUrl: weatherOfToday.iconUrl,
          width: context.getDynamicWidth(20),
        ),
        // status
        Padding(
          padding: EdgeInsets.only(top: context.normalValue, bottom: context.lowValue),
          child: Text(weatherOfToday.description, style: context.currentThemeData.currentAppFonts.totalTitleStyle.copyWith(color: colorData)),
        ),
        // degree
        Text("${weatherOfToday.degree} \u00b0C", style: context.currentThemeData.currentAppFonts.bigTitle.copyWith(color: colorData),),
        // weather details
        Padding(
          padding: context.paddingMediumVertical,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // night degree
              Row(
                children: [
                   Icon(Icons.nights_stay_outlined, size: 22, color: colorData),
                  Text("${weatherOfToday.degreeOnNight} \u00b0", style: context.currentThemeData.currentAppFonts.title2.copyWith(color: colorData)),
                ],
              ),
              // max degree
              Row(
                children: [
                   Icon(Icons.keyboard_double_arrow_up_rounded, color: colorData),
                  Text("${weatherOfToday.maxDegree} \u00b0", style: context.currentThemeData.currentAppFonts.title2.copyWith(color: colorData)),
                ],
              ),
              // min degree
              Row(
                children: [
                   Icon(Icons.keyboard_double_arrow_down_rounded, color: colorData),
                  Text("${weatherOfToday.minDegree} \u00b0",style: context.currentThemeData.currentAppFonts.title2.copyWith(color: colorData)),
                ],
              ),
              // humidity
              Row(
                children: [
                   Icon(Icons.water_drop_outlined, size: 20, color: colorData),
                  Text("${weatherOfToday.humidity.toInt()}%", style: context.currentThemeData.currentAppFonts.title2.copyWith(color: colorData))
                ],
              ),
            ],
          ),
        ),
    
      ],
    );
  }
}


