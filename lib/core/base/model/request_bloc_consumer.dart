
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/base/model/request_failed.dart';
import '../../constants/navigation/navigation_constants.dart';
import '../../constants/network/error_types.dart';
import '../../init/cache/locale_manager.dart';
import '../../init/navigation/navigation_service.dart';
import '../../init/network/bloc/request_bloc.dart';
import 'base_response_model.dart';
import "request_bloc_builder.dart";
import "request_bloc_listener.dart";

//
/// It is a combination of [RequestBlocListener] and [RequestBlocBuilder], similar to [BlocConsumer].
//
class RequestBlocConsumer<T extends BaseResponseModel<T>> extends StatelessWidget {
  final Widget Function(BuildContext context, )? onLoadingBuilder;
  final Widget Function(BuildContext context, RequestSuccess<T> successObject)? onSuccessBuilder;
  final Widget Function(BuildContext context, RequestError error)? onJoiErrorBuilder;
  final Widget Function(BuildContext context, RequestError error)? onInvalidValueErrorBuilder;
  final Widget Function(BuildContext context, RequestError error)? onLogicalErrorBuilder;
  final Widget Function(BuildContext context, RequestError error)? onDataNotFoundErrorBuilder;
  final Widget Function(BuildContext context, RequestError error)? onAuthorizationErrorBuilder;
  final Widget Function(BuildContext context, RequestError error)? onExpiredRefreshTokenBuilder;
  final void Function(BuildContext context, )? onLoadingListener;
  final void Function(BuildContext context, RequestSuccess<T> successObject)? onSuccessListener;
  final void Function(BuildContext context, RequestError error)? onJoiErrorListener;
  final void Function(BuildContext context, RequestError error)? onInvalidValueErrorListener;
  final void Function(BuildContext context, RequestError error)? onLogicalErrorListener;
  final void Function(BuildContext context, RequestError error)? onDataNotFoundErrorListener;
  final void Function(BuildContext context, RequestError error)? onAuthorizationErrorListener;
  final void Function(BuildContext context, RequestError error)? onExpiredRefreshTokenListener;
  final bool Function(RequestState previous, RequestState current)? buildWhen;
  final bool Function(RequestState previous, RequestState current)? listenWhen;
  final Widget Function(BuildContext context, RequestError error)? onErrorOfAllBuilding;
  final void Function(BuildContext context, RequestError error)? onErrorOfAllListening;
  final Widget Function(BuildContext context, RequestFailed failedObject)? onRequestFailedBuilding;
  final void Function(BuildContext context, RequestFailed failedObject)? onRequestFailedListening;
  final bool? finishWithOnErrorOfAllListening;

  const RequestBlocConsumer({
    Key? key,
    this.onRequestFailedBuilding,
    this.onRequestFailedListening,
    this.onLoadingBuilder,
    this.onSuccessBuilder,
    this.onJoiErrorBuilder,
    this.onInvalidValueErrorBuilder,
    this.onLogicalErrorBuilder,
    this.onDataNotFoundErrorBuilder,
    this.onAuthorizationErrorBuilder,
    this.onExpiredRefreshTokenBuilder,
    this.onLoadingListener,
    this.onSuccessListener,
    this.onJoiErrorListener,
    this.onInvalidValueErrorListener,
    this.onLogicalErrorListener,
    this.onDataNotFoundErrorListener,
    this.onAuthorizationErrorListener,
    this.onExpiredRefreshTokenListener,
    this.buildWhen,
    this.listenWhen,
    this.onErrorOfAllBuilding,
    this.onErrorOfAllListening,
    this.finishWithOnErrorOfAllListening,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RequestBloc<T>, RequestState>(
      listenWhen: listenWhen,
      buildWhen: buildWhen,
      builder:(context, state) {
        if(state is RequestLoading){
          return onLoadingBuilder?.call(context, ) ?? Container();
        }
        else if(state is RequestSuccess<T>){
          return onSuccessBuilder?.call(context, state) ?? Container();
        }
        else if(state is RequestError){
          if(state.error.errorType == ApiErrorTypes.invalidValue){
            return onInvalidValueErrorBuilder?.call(context, state) ?? Container();
          }
          else if(state.error.errorType == ApiErrorTypes.logicalError){
            return onLogicalErrorBuilder?.call(context, state) ?? Container();
          }
          else if(state.error.errorType == ApiErrorTypes.joiError){
            return onJoiErrorBuilder?.call(context, state) ?? Container();
          }
          else if(state.error.errorType == ApiErrorTypes.authorizationError){
            return onAuthorizationErrorBuilder?.call(context, state) ?? Container();
          }
          else if(state.error.errorType == ApiErrorTypes.dataNotFound){
            return onDataNotFoundErrorBuilder?.call(context, state) ?? Container();
          }
          else if(state.error.errorType == ApiErrorTypes.expiredRefreshToken){
            return onExpiredRefreshTokenBuilder?.call(context, state) ?? Container();
          }
          else{
            return Container();
          }
        }
        else{
          return onRequestFailedBuilding?.call(context, state as RequestFailed) ?? Container();
        }
      },
      listener:(context, state) {
        if(state is RequestLoading){
          onLoadingListener?.call(context, );
        }
        else if(state is RequestSuccess<T>){
          onSuccessListener?.call(context, state);
        }
        else if(state is RequestError){
          if(finishWithOnErrorOfAllListening == true) {
            onErrorOfAllBuilding?.call(context, state);
            return; 
          }
          else{
            onErrorOfAllBuilding?.call(context, state);
          }
          if(state.error.errorType == ApiErrorTypes.invalidValue){
            onInvalidValueErrorListener?.call(context, state);
          }
          else if(state.error.errorType == ApiErrorTypes.logicalError){
            onLogicalErrorListener?.call(context, state);
          }
          else if(state.error.errorType == ApiErrorTypes.joiError){
            onJoiErrorListener?.call(context, state);
          }
          else if(state.error.errorType == ApiErrorTypes.authorizationError){
            onAuthorizationErrorListener?.call(context, state);
          }
          else if(state.error.errorType == ApiErrorTypes.dataNotFound){
            onDataNotFoundErrorListener?.call(context, state);
          }
          else if(state.error.errorType == ApiErrorTypes.expiredRefreshToken){
            onExpiredRefreshTokenListener != null ? onExpiredRefreshTokenListener!(context, state) : () async {
              await LocaleManager.instance.logout();
              NavigationService.instance.navigateToPageClear(path: NavigationConstants.LOGIN_VIEW);
            }();
          }
          else{
            return;
          }
        }
        else{
          onRequestFailedListening?.call(context, state as RequestFailed);        
        }
      },
    );
  }
}

