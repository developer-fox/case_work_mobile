
import 'package:dio/dio.dart';

// abstract class for internet operations
// The data received as a result of http requests comes in the form of classes inherited from this class.
abstract class ApiClasses{
  RequestOptions? requestOptions;
}