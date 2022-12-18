
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:weather_app/components/entity/turkey_cities.dart';
import 'package:weather_app/components/panel/weather_of_day_panel.dart';
import 'package:weather_app/components/tile/weather_of_day_tile.dart';
import 'package:weather_app/core/base/model/request_bloc_builder.dart';
import 'package:weather_app/core/base/state/base_state.dart';
import 'package:weather_app/core/base/view/base_view.dart';
import 'package:weather_app/core/constants/app/environment_variables.dart';
import 'package:weather_app/core/extension/context_extension.dart';
import 'package:weather_app/core/extension/string_extension.dart';
import 'package:weather_app/core/init/language/locale_keys.g.dart';
import 'package:weather_app/core/init/network/bloc/request_bloc.dart';
import 'package:weather_app/core/init/network/network_manager.dart';
import 'package:weather_app/view/weather_of_week/model/single_day_weather_model.dart';
import 'package:weather_app/view/weather_of_week/model/weather_of_week_response_model.dart';
import 'package:weather_app/view/weather_of_week/viewmodel/bloc/weather_of_week_vm_bloc.dart';

class WeatherOfWeekView extends StatefulWidget {
  final String activityId;
  const WeatherOfWeekView({
    Key? key,
    required this.activityId,
  }) : super(key: key);

  @override
  State<WeatherOfWeekView> createState() => _WeatherOfWeekViewState();
}

class _WeatherOfWeekViewState extends BaseState<WeatherOfWeekView> {
  final refreshController = RefreshController();
  final openablePanelController = PanelController();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: ((context) => RequestBloc<WeatherOfWeekResponseModel>())),
        BlocProvider(create: ((context) => WeatherOfWeekVmBloc())),
      ],
      child: Builder(
        builder: (context) {
          return BaseView(
            onModelReady: () {
              final requestMethod = NetworkManagement.instance.getDio("/activity/get_weather/${widget.activityId}", responseModel: WeatherOfWeekResponseModel.blank());
              context.read<RequestBloc<WeatherOfWeekResponseModel>>().add(SendRequestEvent(requestMethod: requestMethod));
            },
            onConnectionBuilder:(context) {
              return Scaffold(
                appBar: AppBar(title: Text(LocaleKeys.weatherOfWeek_appbarTitle.locale)),
                body: SlidingUpPanel(
                  backdropEnabled: true,
                  backdropOpacity: .3,
                  controller: openablePanelController,
                  panelSnapping: false,
                  borderRadius: const BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15),),
                  minHeight: 0,
                  maxHeight:  context.getDynamicHeight(42),
                  defaultPanelState: PanelState.CLOSED,
                  panel: BlocBuilder<WeatherOfWeekVmBloc, WeatherOfWeekVmState>(
                    buildWhen: (previous, current) => previous.panelWeatherModel != current.panelWeatherModel,
                    builder:(context, state) {
                      return state.panelWeatherModel == null ? Container() : WeatherOfDayPanel(weatherModel: state.panelWeatherModel, colorData: Colors.black,);
                    },
                  ),
                  body: SmartRefresher(
                    physics: null,
                    enablePullDown: true,
                    enablePullUp: false,
                    controller: refreshController,
                    header: MaterialClassicHeader(color: currentThemeData.colorScheme.primary,),
                    onRefresh: () {
                      final requestMethod = NetworkManagement.instance.getDio("/activity/get_weather/${widget.activityId}", responseModel: WeatherOfWeekResponseModel.blank());
                      context.read<RequestBloc<WeatherOfWeekResponseModel>>().add(SendRequestEvent(requestMethod: requestMethod));
                      refreshController.refreshCompleted();
                    },
                    child: RequestBlocBuilder<WeatherOfWeekResponseModel>(
                      onLoading: (context) {
                        return const Center(child: CircularProgressIndicator());
                      },
                      onSuccess:(context, successObject) {
                        SingleDayWeatherModel weatherOfToday = successObject.data.weatherModels.first;
                      weatherOfToday.day = successObject.data.city;
                        final cityIndexOnAllCities = CitiesOfTurkey.instance.cities.indexOf(successObject.data.city);
                        return Stack(
                          children: [
                          // background image
                          SizedBox.expand(
                            child: CachedNetworkImage(
                              imageUrl: "${EnvironmentVariables.awsS3RouteUrl}/city_photos/$cityIndexOnAllCities.jpg", 
                              fit: BoxFit.cover,
                              color: Colors.black.withOpacity(.3),
                              colorBlendMode: BlendMode.colorDodge,
                              progressIndicatorBuilder: (context, widget, chunks) {
                                return const Shimmer(
                                  period: Duration(milliseconds: 300),
                                  gradient: LinearGradient(colors: [Colors.grey, Colors.white]),
                                  child:  SizedBox.expand(),
                                );
                              },
                            ),
                          ),
                            Column(
                              children: [
                                WeatherOfDayPanel(weatherModel: weatherOfToday, colorData: Colors.white,),
                                // weather of week
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: successObject.data.weatherModels.length -1,
                                  itemBuilder:(context, index) {
                                    final currentModel = successObject.data.weatherModels[index +1];
                                    return WeatherOfDayTile(
                                      singleDayWeatherModel: currentModel, 
                                      onPressed: () {
                                        context.read<WeatherOfWeekVmBloc>().add(ChangePanelWeatherModelEvent(weatherModel: currentModel));
                                        openablePanelController.open();
                                      },
                                    );
                                  }, 
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          );
        }
      ),
    );
  }
}