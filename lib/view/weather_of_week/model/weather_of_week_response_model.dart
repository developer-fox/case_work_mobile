
import 'package:dio/dio.dart';
import 'package:weather_app/view/weather_of_week/model/single_day_weather_model.dart';
import '../../../core/base/model/base_response_model.dart';

class WeatherOfWeekResponseModel extends BaseResponseModel<WeatherOfWeekResponseModel> {
  late List<SingleDayWeatherModel> weatherModels;
  late String city;
  WeatherOfWeekResponseModel({
    required this.weatherModels,
    required this.city,
    required RequestOptions requestOptions,
  }){
    this.requestOptions = requestOptions;
  }

  WeatherOfWeekResponseModel.blank();

  @override
  WeatherOfWeekResponseModel fromResponse(Object jsonData, RequestOptions requestOptions) {
    jsonData = jsonData as Map<String,dynamic>;
    return WeatherOfWeekResponseModel(
      requestOptions: requestOptions,
      city: jsonData["city"],
      weatherModels: (jsonData["result"] as List).cast<Map<String,dynamic>>().map((e) => SingleDayWeatherModel.blank().fromResponse(e, requestOptions)).toList(), 
    );
  }
}
