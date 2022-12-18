import 'package:weather_app/core/base/model/api_classes.dart';

//If data is to be found in the body of the http request, classes inherited from this class are used.
/// inherited from [ApiClasses]
abstract class BaseRequestModel extends ApiClasses{
  /// The data is transmitted to the body of the http request by using the [toJson] method of the object produced from the class that derives from this class.
  Object toJson();
}
