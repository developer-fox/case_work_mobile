
// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
part 'connectivity_event.dart';
part 'connectivity_state.dart';

/// [ConnectivityBloc] objects are used to convey information about the current internet connection to different parts of the application.
class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  late Connectivity _connectivity;
  late StreamSubscription<ConnectivityResult> _subscription;
  ConnectivityBloc() : super(ConnectivityInitial()) {
    _connectivity = Connectivity();
    _subscription = _connectivity.onConnectivityChanged.listen((event) {
      /// new status is added to stream when internet connection status changes
      emit(event == ConnectivityResult.none ? ConnectionNone(): ConnectionEnabled());
    },);
  }  

  /// When object [ConnectivityBloc] is closed, we also turn off its [_subscription] to the internet state stream.
  @override 
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}