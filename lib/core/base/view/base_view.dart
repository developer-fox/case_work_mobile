
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/base/state/base_state.dart';
import 'package:weather_app/core/init/network/connectivity/connectivity_bloc.dart';
import '../../../components/page/no_connection_page.dart';

/// [BaseView] class is used as the page superclass. thanks to this class we can manage all our pages in the context of a class.
class BaseView extends StatefulWidget {
  /// [onModelReady] method is executed in initState.
  final void Function()? onModelReady;
  //
  /// [onModelDispose] method is executed in dispose.
  final void Function()? onModelDispose;
  //
  /// [onModelDeactivate] method is executed in deactivate.
  final void Function()? onModelDeactivate;
  //
  /// The [onConnectionBuilder] method is run inside the [build] method. If there is no internet connection, the widget tree defined in this method is built. if this method is not defined, an already defined widget is built.
  final Widget Function(BuildContext context)? onNoConnectionBuilder;
  //
  /// The [onConnectionBuilder] method is run inside the [build] method. If there is internet connection, the widget tree defined in this method is built.
  final Widget Function(BuildContext context) onConnectionBuilder;
  const BaseView({
    Key? key,
    this.onModelReady,
    this.onModelDispose,
    this.onModelDeactivate,
    this.onNoConnectionBuilder,
    required this.onConnectionBuilder,
  }) : super(key: key);
  @override
  State<BaseView> createState() => _BaseViewState();
}

class _BaseViewState extends BaseState<BaseView> {
  @override
  void initState() {
    widget.onModelReady?.call();
    super.initState();
  }
  @override
  void dispose() {
    widget.onModelDispose?.call();
    super.dispose();
  }
  @override
  void deactivate() {
    widget.onModelDeactivate?.call(); 
    super.deactivate();
  }
  @override
  Widget build(BuildContext context) {
   return BlocBuilder<ConnectivityBloc,ConnectivityState>(
     buildWhen: (previous, current) => previous.runtimeType != current.runtimeType,
     builder: ((context, state) {
       if(state is ConnectionEnabled){
         return widget.onConnectionBuilder(context);
       }
       else{
         return widget.onNoConnectionBuilder == null ? const NoConnectionPage() : widget.onNoConnectionBuilder!(context);
       }
     })
   ); 
  }
}