
import 'package:dio/dio.dart';

import '../../../core/base/model/base_response_model.dart';

class GetActivityResponseModel extends BaseResponseModel<GetActivityResponseModel> {
  late String activityId;
  late String city;
  late String venue;
  late String title;
  late String description;
  late DateTime date;
  late String category;

  GetActivityResponseModel({
    required this.activityId,
    required this.city,
    required this.venue,
    required this.title,
    required this.description,
    required this.date,
    required this.category,
  });
  
  GetActivityResponseModel.blank();

  @override
  GetActivityResponseModel fromResponse(Object jsonData, RequestOptions requestOptions) {
    jsonData = jsonData as Map<String, dynamic>;
    return GetActivityResponseModel(activityId: jsonData["_id"], city: jsonData["city"], venue: jsonData["venue"], title: jsonData["title"], description: jsonData["description"], date: DateTime.parse(jsonData["date"]), category: jsonData["category"]);
  }
}

class AllActivitiesResponseModel extends BaseResponseModel<AllActivitiesResponseModel> {
  late List<GetActivityResponseModel> models;
  AllActivitiesResponseModel({
    required this.models,
  });
  
  AllActivitiesResponseModel.blank();
  
  @override
  AllActivitiesResponseModel fromResponse(Object jsonData, RequestOptions requestOptions) {
    jsonData = (jsonData as List).cast<Map<String, dynamic>>();
    return AllActivitiesResponseModel(models: jsonData.map((e) {
      return GetActivityResponseModel.blank().fromResponse(e, requestOptions);
    }).toList());
  }
}