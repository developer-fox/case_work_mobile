part of 'connectivity_bloc.dart';

abstract class ConnectivityState {}

class ConnectivityInitial extends ConnectivityState {}

/// If there is no internet connection, [ConnectionNone] objects are added to the stream
class ConnectionNone extends ConnectivityState {
  ConnectionNone();
}

/// [ConnectionEnabled] objects are added to stream if internet connection is available
class ConnectionEnabled extends ConnectivityState {
  ConnectionEnabled();
}
