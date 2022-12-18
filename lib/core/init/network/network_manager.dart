
import 'package:dio/dio.dart';
import 'package:weather_app/core/base/model/request_failed.dart';
import 'package:weather_app/core/constants/app/environment_variables.dart';
import 'package:weather_app/core/constants/navigation/navigation_constants.dart';
import 'package:weather_app/core/init/navigation/navigation_service.dart';
import '../../base/model/api_classes.dart';
import '../../base/model/base_error.dart';
import '../../base/model/base_request_model.dart';
import '../../base/model/base_response_model.dart';
import '../../base/model/unmodified_response_model.dart';
import '../../constants/enums/locale_keys_enum.dart';
import '../../constants/network/error_types.dart';
import '../cache/locale_manager.dart';
import "bloc/request_bloc.dart";

/// It allows us to perform [NetworkManagement] class internet operations with a single instance in a performance and manageable way.
//* this class ensures that only http requests are made and results are converted from required classes to objects.
/// [RequestBloc] objects are responsible for transmitting result objects within the application.
class NetworkManagement{
  static NetworkManagement? _instance;
  static NetworkManagement get instance{
    _instance ??= NetworkManagement._init();
    return _instance!;
  }

  late final Dio _dio;

  Dio get dio => _dio;

  /// [_responseModelReturner] converts the result of the internet transaction to the required response object
  ApiClasses _responseModelReturner(Response<dynamic> response, BaseResponseModel? responseModel){
    Map<int, Function()> objectLiteral = {
      401: (){
        return BaseError(errorType: ApiErrorTypes.authorizationError, message: response.data["description"], requestOptions: response.requestOptions);
      },
      444: (){
        return BaseError(errorType: ApiErrorTypes.dataNotFound, message: response.data["description"], requestOptions: response.requestOptions);
      },
      407: () async{
        await LocaleManager.instance.logout();
        await NavigationService.instance.navigateToPageClear(path: NavigationConstants.LOGIN_VIEW);
        return BaseError(errorType: ApiErrorTypes.expiredRefreshToken, message: response.data ["description"], requestOptions: response.requestOptions);
      },
      400: (){
        return BaseError(errorType: ApiErrorTypes.invalidValue, message: response.data["description"], requestOptions: response.requestOptions);
      },
      412: (){
        return BaseError(errorType: ApiErrorTypes.jwtError, message: response.data["description"], requestOptions: response.requestOptions);
      },
      416: (){
        return BaseError(errorType: ApiErrorTypes.logicalError, message: response.data["description"], requestOptions: response.requestOptions);
      },
      500: (){
        return BaseError(errorType: ApiErrorTypes.serverError, message: "an error occured on server", requestOptions: response.requestOptions);
      },
      422: (){
        return BaseError(errorType: ApiErrorTypes.joiError, message: response.data.toString(), requestOptions: response.requestOptions);
      },
      200: (){
        return responseModel == null ? UnmodifiedResponseDataModel(data: response.data) : responseModel.fromResponse(response.data, response.requestOptions);
      }, 
    };
    return objectLiteral[response.statusCode] == null ? RequestFailed(): objectLiteral[response.statusCode]!();
  }

  NetworkManagement._init(){
    // BaseOptions objects create configuration in internet operations with dio package.
    final BaseOptions baseOptions = BaseOptions(
      baseUrl: EnvironmentVariables.apiMainRoute,
    );

    _dio = Dio(baseOptions);

    // interceptors can be qualified as middleware in internet transactions with dio. 
    //every incoming response, every outgoing request and every error is given after passing through interceptors and processed.
    _dio.interceptors.add(InterceptorsWrapper(
      // jwt is used in session operations. jwts are stored in the app's local storage.
      // All routes except auth routes require jwt. 
      //this interceptor takes jwt information from local storage according to the requested route and adds it to the headers
      onRequest: (options, handler) {
        if(options.path.split("/")[1] != "auth" && LocaleManager.instance.getStringValue(PreferencesKeys.x_access_key) != "" && LocaleManager.instance.getStringValue(PreferencesKeys.x_access_refresh_key) != "") {
          options.headers["x-access-key"] = LocaleManager.instance.getStringValue(PreferencesKeys.x_access_key);
          options.headers["x-access-refresh-key"] = LocaleManager.instance.getStringValue(PreferencesKeys.x_access_refresh_key);
        }
        return handler.next(options);
      },
      // The expiry time of jwt tokens is set to 1 hour. Instead of expired tokens, new ones are sent in the response header. 
      // this interceptor checks the token in the header and if a new token has arrived, it saves it for future requests.
      onResponse: (response, handler) async {
         if(response.headers.value("x-access-key") != null && (response.headers.value("x-access-key")) != LocaleManager.instance.getStringValue(PreferencesKeys.x_access_key)){
          await LocaleManager.instance.setStringValue(PreferencesKeys.x_access_key, response.headers.value("x-access-key")!);
        }
        return handler.next(response);
      },
      onError: (e, handler) {
        final createdResponse = Response(
          requestOptions: e.requestOptions,
          data: null,
        );
        return handler.resolve(e.response ?? createdResponse);
      },
    ));

  }

  // method for get requests
  Future<ApiClasses> getDio(String path,{BaseRequestModel? requestModel, BaseResponseModel? responseModel}) async{
    final response = await _dio.get(path);
    return _responseModelReturner(response, responseModel);
  }

  // method for post requests
  Future<ApiClasses> postDio(String path,{BaseRequestModel? requestModel, BaseResponseModel? responseModel}) async{
    final response = await _dio.post(path, data: requestModel?.toJson());
    return _responseModelReturner(response, responseModel);
  }

  // method for delete requests
  Future<ApiClasses> deleteDio(String path,{BaseRequestModel? requestModel, BaseResponseModel? responseModel}) async{
    final response = await _dio.delete(path, data: requestModel?.toJson());
    return _responseModelReturner(response, responseModel);
  }

  // method for put requests
  Future<ApiClasses> putDio(String path,{BaseRequestModel? requestModel, BaseResponseModel? responseModel}) async{
    final response = await _dio.put(path, data: requestModel?.toJson());
    return _responseModelReturner(response, responseModel);
  }
}
