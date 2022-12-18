import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../../base/model/api_classes.dart';
import '../../../base/model/base_error.dart';
import '../../../base/model/base_response_model.dart';
part 'request_event.dart';
part 'request_state.dart';

/// [RequestBloc] is the block class defined to effectively transfer internet transactions within the application.
/// Thanks to the [T] type given to it, it knows what type of data the response result will return, and when the operation is successful, it adds the data it receives to the stream as a [T] object in a [RequestSuccess].
/// if the http request returns an [BaseError] object, it streams that object as a [BaseError] object in [RequestError].
class RequestBloc<T extends BaseResponseModel<T>> extends Bloc<RequestEvent, RequestState> {
  static Connectivity connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _subscription;
  late Future<ApiClasses> lastRequestMethod;
  RequestBloc() : super(RequestInitial()) {
    _subscription = connectivity.onConnectivityChanged.listen((event) {
      if(event != ConnectivityResult.none) add(SendRequestEvent(requestMethod: lastRequestMethod));
    });
    on<SendRequestEvent>(_onSendRequest);
  }

  /// When the [SendRequestEvent] event is triggered, it runs the method that will return objects from the [ApiClasses] class in that event. emits [RequestLoading] before starting. It makes the necessary publications according to the result after the run.
  Future<void> _onSendRequest(SendRequestEvent event, Emitter<RequestState> emit) async {
    emit(RequestLoading());
    lastRequestMethod = event.requestMethod;
    final fetchResult = await event.requestMethod;
    if(fetchResult is BaseError){
      emit(RequestError(error: fetchResult));
    }
    if(fetchResult is T){
      emit(RequestSuccess<T>(data: fetchResult));
    }
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}