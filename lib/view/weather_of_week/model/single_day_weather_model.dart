
import 'package:dio/dio.dart';

import '../../../core/base/model/base_response_model.dart';

class SingleDayWeatherModel extends BaseResponseModel<SingleDayWeatherModel> {
  late String date;
  late String day;
  late String iconUrl;
  late String description;
  late String status;
  late int degree;
  late int minDegree;
  late int maxDegree;
  late int degreeOnNight;
  late double humidity;

  SingleDayWeatherModel({
    required this.date,
    required this.day,
    required this.iconUrl,
    required this.description,
    required this.status,
    required this.degree,
    required this.minDegree,
    required this.maxDegree,
    required this.degreeOnNight,
    required this.humidity,
  });

  SingleDayWeatherModel.blank();

  @override
  SingleDayWeatherModel fromResponse(Object jsonData, RequestOptions requestOptions) {
    jsonData = jsonData as Map<String,dynamic>;
    return SingleDayWeatherModel(
      date: jsonData["date"], 
      day: jsonData["day"],  
      iconUrl: jsonData["icon"], 
      description: jsonData["description"], 
      status: jsonData["status"], 
      degree: double.parse(jsonData["degree"]).toInt(), 
      minDegree: double.parse(jsonData["min"]).toInt(), 
      maxDegree: double.parse(jsonData["max"]).toInt(), 
      degreeOnNight: double.parse(jsonData["night"]).toInt(), 
      humidity:  double.parse(jsonData["humidity"]),
    );
  }
}