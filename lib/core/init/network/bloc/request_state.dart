part of 'request_bloc.dart';

abstract class RequestState {}

class RequestInitial extends RequestState {}

/// [RequestLoading] is added to the stream before the http request is made. In this way, what needs to be loading the installation can be done by the subscribers.
/// optionally, previously retrieved data for pagination operations can be kept in objects of [RequestLoading].
class RequestLoading<T> extends RequestState {
  final T? paginationDatas;
  RequestLoading({this.paginationDatas});
}

///When the http request is successful, these [RequestSuccess] objects are added to the stream. In this way, subscribers can take necessary actions. 
/// With the defined [T] type, it is specified what kind of data the operation will return.
class RequestSuccess<T extends BaseResponseModel<T>> extends RequestState {
  final T data;
  RequestSuccess({
    required this.data,
  });
}

/// [RequestError] objects are added to the stream when the http request results in an error
/// Thanks to the [BaseError] object in it, subscribers can take actions related to the error.
class RequestError extends RequestState {
  final BaseError error;
  RequestError({
    required this.error,
  });
}