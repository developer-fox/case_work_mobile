
import 'package:dio/dio.dart';
import 'package:weather_app/core/base/model/base_response_model.dart';

//
/// If the method that will make the http request is not given an object that inherits class [BaseResponseModel], the mentioned method automatically creates an object of class [UnmodifiedResponseDataModel] and passes it to the corresponding block stream.
// 
class UnmodifiedResponseDataModel extends BaseResponseModel<UnmodifiedResponseDataModel> {
  late dynamic data;
  UnmodifiedResponseDataModel({
    required this.data,
  });
  @override
  UnmodifiedResponseDataModel fromResponse(Object jsonData, RequestOptions requestOptions) {
    return UnmodifiedResponseDataModel(data: jsonData);
  }
}