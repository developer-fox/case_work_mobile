
import '../../../core/base/model/base_request_model.dart';

class CreateActivityRequestModel extends BaseRequestModel {
  late String title;
  late String description;
  late String city;
  late String venue;
  late String category;
  late DateTime date;

  CreateActivityRequestModel({
    required this.title,
    required this.description,
    required this.city,
    required this.venue,
    required this.category,
    required this.date,
  });

  @override
  Object toJson() {
    return  {
      "title": title,
      "description": description,
      "city": city,
      "venue": venue,
      "category": category,
      "date": date.toIso8601String()
    };
  }
}