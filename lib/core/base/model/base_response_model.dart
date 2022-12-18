
import 'package:dio/dio.dart';

import 'api_classes.dart';

// The data successfully returned as a result of the http request is transmitted within the application in the form of objects from classes derived from this class.
//
/// inherited from [ApiClasses]
abstract class BaseResponseModel<T> extends ApiClasses{
  /// The type [T] passed to the class determines what type of object this class will produce.
  //
  /// The data received as a result of the http request is converted into an object and transmitted by using the [fromResponse] method of objects produced from classes derived from this class.
  T fromResponse(Object jsonData, RequestOptions requestOptions);
}