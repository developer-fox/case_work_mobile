
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_app/core/extension/context_extension.dart';
import 'package:weather_app/core/extension/datetime_extension.dart';
import 'package:weather_app/core/extension/themedata_extension.dart';
import '../../view/home/model/activities_response_model.dart';

class ActivityListTile extends StatelessWidget {
  final GetActivityResponseModel activityModel; 
  final void Function() onPressed;
  final void Function() onLongPress;
  final Color? backgroundColor;
  final Icon suffixIcon;
  final void Function()? suffixIconOnPressed;
  const ActivityListTile({
    Key? key,
    required this.activityModel,
    required this.onPressed,
    required this.onLongPress,
    this.backgroundColor,
    required this.suffixIcon,
    this.suffixIconOnPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      onLongPress: onLongPress,
      child: Container(
        color: backgroundColor,
        child: Padding(
          padding: context.paddingLow,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: context.getDynamicWidth(100) - context.lowValue *2,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // title
                        SizedBox(
                          width: context.getDynamicWidth(70),
                          child: Text(activityModel.title, style: context.currentThemeData.currentAppFonts.settingsTitleStyle,)
                        ),
                        const Spacer(),
                        // date
                        Text(activityModel.date.toDate, style: context.currentThemeData.currentAppFonts.dateHourStyle.copyWith(fontStyle: FontStyle.italic)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: context.lowValue),
                    child: SizedBox(
                      width: context.getDynamicWidth(70),
                      child: Row(
                        children: [
                          FaIcon(FontAwesomeIcons.hashtag, size: 14, color: context.currentThemeData.colorScheme.secondary.withOpacity(.8)),
                          // category
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Text(activityModel.category, style: context.currentThemeData.currentAppFonts.subTitle2),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: context.paddingLowVertical,
                    child: SizedBox(
                      width: context.getDynamicWidth(100) - context.lowValue *2,
                      child: Row(
                        children: [
                          // description
                          SizedBox(
                            width: context.getDynamicWidth(70),
                            child: Text(activityModel.description, style: context.currentThemeData.currentAppFonts.contentParagraph)),
                          const Spacer(),
                          // activity update button
                          IconButton(
                            splashRadius: 24,
                            icon: suffixIcon,
                            onPressed: suffixIconOnPressed,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // location
                  Row(
                    children: [
                      // city and venue
                      const Icon(Icons.location_on_outlined, size: 18, color: Colors.black54),
                      Text("${activityModel.city}, ${activityModel.venue}",style: context.currentThemeData.currentAppFonts.cardSubTitleLocation),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

