
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:weather_app/components/tile/activity_listtile.dart';
import 'package:weather_app/core/base/model/request_bloc_builder.dart';
import 'package:weather_app/core/constants/navigation/navigation_constants.dart';
import 'package:weather_app/core/extension/context_extension.dart';
import 'package:weather_app/core/extension/string_extension.dart';
import 'package:weather_app/core/init/language/locale_keys.g.dart';
import 'package:weather_app/core/init/navigation/navigation_service.dart';
import 'package:weather_app/core/init/network/bloc/request_bloc.dart';
import 'package:weather_app/core/init/network/network_manager.dart';
import 'package:weather_app/view/create_activity/model/create_activity_view_dependency_model.dart';
import 'package:weather_app/view/home/model/activities_response_model.dart';
import 'package:weather_app/view/home/viewmodel/bloc/home_view_vm_bloc.dart';
import '../../../core/base/state/base_state.dart';
import '../../../core/base/view/base_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends BaseState<HomeView> {
  final RefreshController refreshController= RefreshController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: ((context) => RequestBloc<AllActivitiesResponseModel>())),
        BlocProvider(create: ((context) => HomeViewVmBloc())),
      ],
      child: Builder(
        builder: (context) {
          return BaseView(
            onModelReady: () {
              final requestMethod = NetworkManagement.instance.getDio("/activity/get_activities", responseModel: AllActivitiesResponseModel.blank());
              context.read<RequestBloc<AllActivitiesResponseModel>>().add(SendRequestEvent(requestMethod: requestMethod));
            },
              onConnectionBuilder:(context) {
                return Scaffold(
                  appBar: AppBar(title: Text(LocaleKeys.home_appbarTitle.locale), actions: [
                    IconButton(
                      tooltip: LocaleKeys.home_addActivityTooltip.locale,
                      icon: const Icon(Icons.add_box_outlined),
                      onPressed: (){
                        NavigationService.instance.navigateToPage(path: NavigationConstants.CREATE_ACTIVITY_VIEW);
                      },
                    ),
                  ],),
                  body: SmartRefresher(
                  physics: const BouncingScrollPhysics(),
                  enablePullDown: true,
                  enablePullUp: false,
                  controller: refreshController,
                  header: MaterialClassicHeader(color: currentThemeData.colorScheme.primary,),
                  onRefresh: () {
                    final requestMethod = NetworkManagement.instance.getDio("/activity/get_activities", responseModel: AllActivitiesResponseModel.blank());
                    context.read<RequestBloc<AllActivitiesResponseModel>>().add(SendRequestEvent(requestMethod: requestMethod));
                    refreshController.refreshCompleted();
                  },
                    child: RequestBlocBuilder<AllActivitiesResponseModel>(
                      onLoading: (context) {
                        return const Center(child: CircularProgressIndicator());
                      },
                      onSuccess: (context, successObject) {
                        return BlocBuilder<HomeViewVmBloc,HomeViewVmState>(
                          builder: (context,state) {
                            return ListView.separated(
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              itemCount: successObject.data.models.length,
                              itemBuilder:(context, index) {
                                final GetActivityResponseModel currentModel = successObject.data.models[index];
                                return ActivityListTile(
                                  activityModel: currentModel,
                                  backgroundColor: state.focusedItemIndex != index ? null: currentThemeData.colorScheme.primary.withOpacity(.25),
                                  onPressed: state.focusedItemIndex != null ? () => context.read<HomeViewVmBloc>().add(ChangeCurrentFocusedIndex(newIndex: null))
                                    : 
                                    (){
                                      NavigationService.instance.navigateToPage(path: NavigationConstants.WEATHER_OF_WEEK_VIEW, data: currentModel.activityId);
                                    }, 
                                  onLongPress: ()=> context.read<HomeViewVmBloc>().add(ChangeCurrentFocusedIndex(newIndex: index)), 
                                  suffixIcon: Icon(state.focusedItemIndex == index ? Icons.update_rounded : Icons.keyboard_arrow_right_rounded, color: state.focusedItemIndex == index ? Colors.black54 : Colors.grey ), 
                                  suffixIconOnPressed: state.focusedItemIndex != index ? null: (){
                                    NavigationService.instance.navigateToPage(path: NavigationConstants.CREATE_ACTIVITY_VIEW, data: CreateActivityViewDependencyModel(appbarTitle: LocaleKeys.home_editActivity.locale, title: currentModel.title, description: currentModel.description, city: currentModel.city, venue: currentModel.venue, category: currentModel.category, date: currentModel.date, activityId: currentModel.activityId));
                                    }, 
                                );
                              }, 
                              separatorBuilder:(context, index) {
                                return Divider(
                                  color: Colors.grey.shade300,
                                  indent: context.lowValue,
                                  endIndent: context.lowValue,
                                  thickness: 1,
                                  height: 1,
                                );
                              }, 
                              );
                          }
                        );
                      },
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