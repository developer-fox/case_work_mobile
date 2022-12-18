part of 'request_bloc.dart';

abstract class RequestEvent {}

/// http requests are forwarded to [RequestBloc] via the[requestMethod] object in the [SendRequestEvent]. 
///
/// The [RequestBloc] object runs the method that will return the [ApiClasses] defined in this [SendRequestEvent] and waits for the result and then processes the result.
class SendRequestEvent extends RequestEvent {
  final Future<ApiClasses> requestMethod;
  SendRequestEvent({
    required this.requestMethod,
  });
}
