
// hata sinifidir. Hata islemlerinde mesaj olusturmak icin direkt olarak bu sinifi kullanacagiz.

import 'package:dio/dio.dart';
import 'package:weather_app/core/base/model/api_classes.dart';
import '../../constants/network/error_types.dart';
//Objects generated from this class are passed as a result of HTTP requests that return errors.
/// inherited from [ApiClasses]
class BaseError extends ApiClasses{
  final ApiErrorTypes errorType;
  final String message;
  BaseError({
    required this.errorType,
    required this.message,
    required RequestOptions requestOptions, 
  }){
    this.requestOptions = requestOptions;
  }

}
