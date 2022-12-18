
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/base/model/request_failed.dart';
import '../../constants/navigation/navigation_constants.dart';
import '../../constants/network/error_types.dart';
import '../../init/cache/locale_manager.dart';
import '../../init/navigation/navigation_service.dart';
import '../../init/network/bloc/request_bloc.dart';
import 'base_response_model.dart';
import "api_classes.dart";
import "request_bloc_builder.dart";

// The results of http requests are transmitted within the application using bloc streams.
//
/// [RequestBlocListener] is a BlocListener for running methods using data (must be objects of class [ApiClasses]) added to block streams within the application as a result of http requests.
//
/// Thanks to [RequestBlocListener]'s properties that are produced to use different objects that can be derived from the results of http requests, it becomes easier to manage internet transactions within the context of method running.
//
/// The type [T] inherited from the [BaseResponseModel] class passed to this class is passed to the [RequestBlocListener]'s listener method, which will be executed if the http request is successful. In this way, the developer knows what kind of data to use if the operation is successful, at the same time this [RequestBlocListener] object only tracks [T] type returns.
//
class RequestBlocListener<T extends BaseResponseModel<T>> extends BlocListener<RequestBloc<T>, RequestState>{
  /// The [onLoading] property is for the method to be executed while waiting for the response.
  final void Function(BuildContext context)? onLoading;
  ///If the http request returns with a success code, the [onSuccess] property is executed.
  final void Function(BuildContext context, RequestSuccess<T> successObject)? onSuccess;
  /// if the request returns an error and it is a joi error, method [onJoiError] is executed.
  //
  /// joi errors are errors related to data validation operations. A special status code is reserved for this type of error on the server side.
  final void Function(BuildContext context, RequestError error)? onJoiError;
  /// if the request returns an error and it is a invalid value error, method [onInvalidValueError] is executed.
  final void Function(BuildContext context, RequestError error)? onInvalidValueError;
  /// if the request returns an error and it is a logical error, method [onLogicalError] is executed.
  final void Function(BuildContext context, RequestError error)? onLogicalError;
  /// if the request returns an error and it is a authorization error, method [onAuthorizationError] is executed.
  final void Function(BuildContext context, RequestError error)? onDataNotFoundError;
  /// if the request returns an error and it is a authorization error, method [onAuthorizationError] is executed.
  final void Function(BuildContext context, RequestError error)? onAuthorizationError;
  /// if the request returns an error and it is a expired refresh token error, method [onExpiredRefreshToken] is executed.
  /// In this system, json web tokens are used for session operations.
  final void Function(BuildContext context, RequestError error)? onExpiredRefreshToken;
  /// If we want, we can define a single method to be built for all error types. If [onErrorOfAll] is not null, only this method is run and built in all error types.
  /// Unlike [RequestBlocBuilder], in [RequestBlocListener] the method [onErrorOfAll] may optionally not prevent the execution of methods that are specifically defined for different error conditions.
  final void Function(BuildContext context, RequestError error)? onErrorOfAll;
  /// if the request returns an error and it is a server error, method [onServerError] is executed.
  final void Function(BuildContext context, RequestError error)? onServerError;
  /// if http request action is failed, [onRequestFailed] method is executed.
  final void Function(BuildContext context, RequestFailed failedObject)? onRequestFailed;
  /// [finishWithOnErrorOfAll] determines whether method [onErrorOfAll] prevents it from running other specially designated error methods. The default value is false.
  final bool finishWithOnErrorOfAll;

  RequestBlocListener({
    super.key, 
    super.listenWhen,
    super.child,
    this.onRequestFailed,
    this.onLoading,
    this.onSuccess,
    this.onJoiError,
    this.onInvalidValueError,
    this.onLogicalError,
    this.onDataNotFoundError,
    this.onAuthorizationError,
    this.onExpiredRefreshToken,
    this.onErrorOfAll,
    this.onServerError,
    this.finishWithOnErrorOfAll = false,
  }): super(
    listener: (context, state) {
        if(state is RequestLoading){
          onLoading?.call(context);
        }
        else if(state is RequestSuccess<T>){
          onSuccess?.call(context, state);
        }
        else if(state is RequestError){
          if(finishWithOnErrorOfAll){
            onErrorOfAll?.call(context, state);
            return;
          }
          else{
            onErrorOfAll?.call(context, state);
            if(state.error.errorType == ApiErrorTypes.invalidValue){
              onInvalidValueError?.call(context, state);
            }
            else if(state.error.errorType == ApiErrorTypes.logicalError){
              onLogicalError?.call(context, state);
            }
            else if(state.error.errorType == ApiErrorTypes.joiError){
              onJoiError?.call(context, state);
            }
            else if(state.error.errorType == ApiErrorTypes.authorizationError){
              onAuthorizationError?.call(context, state);
            }
            else if(state.error.errorType == ApiErrorTypes.dataNotFound){
              onDataNotFoundError?.call(context, state);
            }
            else if(state.error.errorType == ApiErrorTypes.serverError){
              onServerError?.call(context, state);
            }
            else if(state.error.errorType == ApiErrorTypes.expiredRefreshToken){
              onExpiredRefreshToken != null ? onExpiredRefreshToken(context, state) : () async {
                await LocaleManager.instance.logout();
                NavigationService.instance.navigateToPageClear(path: NavigationConstants.LOGIN_VIEW);
              }();
            }
            else{
              return;
            }
          }
        }
        else{
          onRequestFailed?.call(context, state as RequestFailed);
        }
      },
    );  
}
