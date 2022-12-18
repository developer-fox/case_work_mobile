
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:weather_app/components/dialog/loading_show_dialog.dart';
import 'package:weather_app/components/dialog/show_invalid_informations_dialog.dart';
import 'package:weather_app/components/entity/turkey_cities.dart';
import 'package:weather_app/components/input/default_textfield.dart';
import 'package:weather_app/core/base/model/request_bloc_listener.dart';
import 'package:weather_app/core/base/model/unmodified_response_model.dart';
import 'package:weather_app/core/base/view/base_view.dart';
import 'package:weather_app/core/constants/navigation/navigation_constants.dart';
import 'package:weather_app/core/extension/context_extension.dart';
import 'package:weather_app/core/extension/datetime_extension.dart';
import 'package:weather_app/core/extension/string_extension.dart';
import 'package:weather_app/core/extension/themedata_extension.dart';
import 'package:weather_app/core/init/language/locale_keys.g.dart';
import 'package:weather_app/core/init/network/bloc/request_bloc.dart';
import 'package:weather_app/core/init/network/network_manager.dart';
import 'package:weather_app/view/create_activity/model/create_activity_request_model.dart';
import 'package:weather_app/view/create_activity/model/create_activity_view_dependency_model.dart';
import 'package:weather_app/view/create_activity/viewmodel/bloc/create_activity_vm_bloc.dart';
import '../../../core/base/state/base_state.dart';
import '../../../core/init/navigation/navigation_service.dart';

class CreateActivityView extends StatefulWidget {
  final CreateActivityViewDependencyModel? dependencyModel;
  const CreateActivityView({
    Key? key,
    this.dependencyModel,
  }) : super(key: key);

  @override
  State<CreateActivityView> createState() => _CreateActivityViewState();
}

class _CreateActivityViewState extends BaseState<CreateActivityView> {
  final DateRangePickerController dateController = DateRangePickerController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController venueController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();

  bool isFieldsValid(CreateActivityVmState state){
    return dateController.selectedDate != null && titleController.text.isNotEmpty && titleController.text.isNotEmpty && descriptionController.text.isNotEmpty && categoryController.text.isNotEmpty &&  venueController.text.isNotEmpty && state.currentFeedbackType != null ;
  }

  bool isFieldsNotEqualWithDependencyModel(CreateActivityVmState state){
    return dateController.selectedDate != widget.dependencyModel!.date || categoryController.text != widget.dependencyModel!.category || titleController.text != widget.dependencyModel!.title || descriptionController.text != widget.dependencyModel!.description || venueController.text != widget.dependencyModel!.venue || state.currentFeedbackType != widget.dependencyModel!.city;
  }


  void checkTheFieldsAndTrigger(BuildContext context, CreateActivityVmState state){
    final validation = widget.dependencyModel == null ? isFieldsValid(state) : isFieldsValid(state) && isFieldsNotEqualWithDependencyModel(state);
    if(validation){
      context.read<CreateActivityVmBloc>().add(ChangeSaveButtonOnPressedEvent(onPressed: saveButtonEnabledMethodReturner(context, state)));
    }
    else{
      context.read<CreateActivityVmBloc>().add(ChangeSaveButtonOnPressedEvent(onPressed: null));
    } 
  }

  void Function() saveButtonEnabledMethodReturner(BuildContext context, CreateActivityVmState state){
    final requestModel = CreateActivityRequestModel(title: titleController.text, description: descriptionController.text, category: categoryController.text, city: state.currentFeedbackType!, venue: venueController.text, date: dateController.selectedDate ?? DateTime.now());
    return widget.dependencyModel == null ? (){
      final requestMethod = NetworkManagement.instance.putDio("/activity/create_activity",requestModel:  requestModel);
      context.read<RequestBloc<UnmodifiedResponseDataModel>>().add(SendRequestEvent(requestMethod: requestMethod));
    }
    :
    (){
      final requestMethod = NetworkManagement.instance.postDio("/activity/update_activity/${widget.dependencyModel!.activityId}",requestModel:  requestModel);
      context.read<RequestBloc<UnmodifiedResponseDataModel>>().add(SendRequestEvent(requestMethod: requestMethod));
    };
  }


  void Function() deleteButtonOnPressedReturner(BuildContext context){
    return(){
      final requestMethod = NetworkManagement.instance.deleteDio("/activity/delete_activity/${widget.dependencyModel?.activityId}");
      context.read<RequestBloc<UnmodifiedResponseDataModel>>().add(SendRequestEvent(requestMethod: requestMethod));
    };
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=> RequestBloc<UnmodifiedResponseDataModel>()),
      ],
      child: Builder(
        builder: (context) {
          return BlocListener<CreateActivityVmBloc, CreateActivityVmState>(
            listenWhen: (previous, current) => previous.currentFeedbackType != current.currentFeedbackType,
            listener: (context, state) {
              checkTheFieldsAndTrigger(context, state);
            },
            child: BaseView(
              onModelReady: () {
                context.read<CreateActivityVmBloc>().add(ClearStates());
                if(widget.dependencyModel != null){
                  context.read<CreateActivityVmBloc>().add(ChangeSelectedCityEvent(city: widget.dependencyModel!.city));
                  context.read<CreateActivityVmBloc>().add(ChangeSelectedDateEvent(selectedDate: widget.dependencyModel!.date));
                  titleController.text = widget.dependencyModel!.title;
                  descriptionController.text = widget.dependencyModel!.description;
                  venueController.text = widget.dependencyModel!.venue;
                  categoryController.text = widget.dependencyModel!.category;
                  dateController.selectedDate = widget.dependencyModel!.date;
                  dateController.displayDate = widget.dependencyModel!.date;
                }
              },
              onConnectionBuilder:(context) {
                return RequestBlocListener<UnmodifiedResponseDataModel>(
                  onLoading: (context) {
                    loadingShowDialog(context);
                  },
                  onErrorOfAll: (context, error) =>  Navigator.of(context).pop(),
                  onSuccess: (context, successObject) {
                    NavigationService.instance.navigateToPageClear(path: NavigationConstants.HOME_VIEW);
                  },
                  onJoiError: (context, error) {
                    showInvalidInformationsDialog(context, LocaleKeys.signup_invalidInputs.locale);
                  },
                  onServerError: (context, error) {
                    showInvalidInformationsDialog(context, LocaleKeys.serverError.locale);
                  },
                  child: Scaffold(
                    appBar: AppBar(title: Text(widget.dependencyModel?.appbarTitle ?? LocaleKeys.createActivity_defaultAppbarTitle.locale), actions: widget.dependencyModel == null ? null: [
                      IconButton(
                        tooltip: LocaleKeys.createActivity_deleteActivityTooltip.locale,
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: (){
                          showDialog(
                            context: context, 
                            builder: ((_) {
                              return AlertDialog(
                                contentPadding: context.paddingMedium,
                                content: Text(LocaleKeys.createActivity_areYouSureForDeleteActivity.locale, style: context.currentThemeData.textTheme.titleSmall),
                                actions: [
                                  TextButton(
                                    onPressed: ()=> Navigator.of(context).pop(),
                                    child: Text(LocaleKeys.createActivity_cancel.locale, style: context.currentThemeData.textTheme.caption?.copyWith(color: Colors.green)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: context.lowValue),
                                    child: TextButton(
                                      onPressed: deleteButtonOnPressedReturner(context),
                                      child: Text(LocaleKeys.createActivity_yes.locale, style: context.currentThemeData.textTheme.caption?.copyWith(color: context.currentThemeData.colorScheme.error)),
                                    ),
                                  ),
                                ],
                              );
                            }) 
                          );
                        },  
                      ),
                    ],),
                    body: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: context.lowValue, vertical: context.normalValue),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                // date button
                                SizedBox(
                                  width: context.getDynamicWidth(50),
                                  height: context.getDynamicHeight(7),
                                  child: TextButton(
                                    onPressed: (){
                                      showDialog(
                                        context: context, 
                                        builder: (dcontext) {
                                          return BlocBuilder<CreateActivityVmBloc, CreateActivityVmState>(
                                            builder: (dcontext,state) {
                                              return Container(
                                                color: currentThemeData.canvasColor,
                                                child: SfDateRangePicker(
                                                controller: dateController,
                                                minDate: DateTime.now(),
                                                onSelectionChanged: (dateRangePickerSelectionChangedArgs) {
                                                  Navigator.of(dcontext).pop();
                                                  context.read<CreateActivityVmBloc>().add(ChangeSelectedDateEvent(selectedDate: dateRangePickerSelectionChangedArgs.value as DateTime));
                                                  checkTheFieldsAndTrigger(context, state);
                                                },
                                                ),
                                              );
                                            }
                                          );
                                        },
                                      );
                                    }, 
                                    child: Text(LocaleKeys.createActivity_selectDate.locale, style: currentThemeData.currentAppFonts.elevatedButtonTextStyle.copyWith(decoration: TextDecoration.underline),),
                                  ),
                                ),
                                // date text
                                Padding(
                                  padding: EdgeInsets.only(top: context.lowValue / 3),
                                  child: BlocBuilder<CreateActivityVmBloc, CreateActivityVmState>(
                                    buildWhen: (previous, current) => previous.selectedDate != current.selectedDate,
                                    builder:(context, state) {
                                      return Visibility(
                                        visible: state.selectedDate != null,
                                        child: Text(state.selectedDate == null ? "" : state.selectedDate!.toDate),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            // city
                            Padding(
                              padding: context.paddingHighVertical * .8,
                              child: DropdownButtonHideUnderline(
                               child: BlocBuilder<CreateActivityVmBloc, CreateActivityVmState>(
                                buildWhen: (previous, current) => previous.currentFeedbackType != current.currentFeedbackType,
                                builder: (context, state) {
                                   return DropdownButton2(
                                      buttonHeight: context.getDynamicWidth(12),
                                      buttonDecoration: BoxDecoration(
                                        color: context.currentThemeData.canvasColor,
                                        border: Border.all(color: state.currentFeedbackType == null ? const Color. fromRGBO(236, 236, 236, 1): context.currentThemeData.colorScheme.primary,  width: 1),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                   icon: Icon(Icons.keyboard_arrow_down_outlined, size: 22,color:context.currentThemeData.colorScheme.primary),
                                   buttonPadding: EdgeInsets.symmetric(horizontal: context.getDynamicWidth(3)),
                                   style: context.currentThemeData.currentAppFonts.textFieldHintStyle,
                                   dropdownElevation: 6,
                                   dropdownDecoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(5),
                                       color: context.currentThemeData.canvasColor
                                   ),
                                   isExpanded: true,
                                   value: state.currentFeedbackType,
                                   onChanged: ((value) {
                                    context.read<CreateActivityVmBloc>().add(ChangeSelectedCityEvent(city: value));
                                   }),
                                   hint: Text(LocaleKeys.createActivity_selectCity.locale),
                                  items: CitiesOfTurkey.instance.cities.map((e) {
                                    return DropdownMenuItem<String>(
                                      value: e,
                                      child: Text(e)
                                    );
                                   }).toList(),
                                   );
                                 }
                               ),
                              ),
                            ),
                            BlocBuilder<CreateActivityVmBloc,CreateActivityVmState>(
                              builder:(context, state) {
                                return Column(
                                  children: [
                            // title
                            DefaultTextField(
                              labelText: LocaleKeys.createActivity_title.locale,
                              borderRadius: 15,
                              controller: titleController,
                              onChanged:(value) {
                                checkTheFieldsAndTrigger(context, state);
                              },
                            ),
                            // description
                            Padding(
                              padding: context.paddingMediumVertical,
                              child: DefaultTextField(
                                borderRadius: 15,
                                labelText:LocaleKeys.createActivity_category.locale,
                                controller: descriptionController,
                                onChanged: (value) {
                                  checkTheFieldsAndTrigger(context,state);
                                },
                              ),
                            ),
                            // category
                            DefaultTextField(
                              borderRadius: 15,
                              labelText: LocaleKeys.createActivity_category.locale,
                              controller: categoryController,
                              onChanged: (value) {
                                checkTheFieldsAndTrigger(context,state);
                              },
                            ),
                            // venue
                            Padding(
                              padding: context.paddingMediumVertical,
                              child: DefaultTextField(
                                borderRadius: 15,
                                labelText: LocaleKeys.createActivity_venue.locale,
                                controller: venueController,
                                onChanged: (value) {
                                  checkTheFieldsAndTrigger(context, state);
                                },
                              ),
                            ),
                                  ],
                                );
                              },
                            ),
                            // create button
                            SizedBox(
                              width: double.maxFinite,
                              height: context.getDynamicHeight(6),
                              child: BlocBuilder<CreateActivityVmBloc, CreateActivityVmState>(
                                buildWhen: (previous, current) => previous.continuButtonOnPressed != current.continuButtonOnPressed,
                                builder:(context, state) {
                                  return ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    onPressed: state.continuButtonOnPressed, 
                                    child: Text(LocaleKeys.createActivity_save.locale),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
      ),
    );
  }
}


