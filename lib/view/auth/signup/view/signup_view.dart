
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/components/dialog/loading_show_dialog.dart';
import 'package:weather_app/components/dialog/login_invalid_informations_dialog.dart';
import 'package:weather_app/components/dialog/show_invalid_informations_dialog.dart';
import 'package:weather_app/core/base/model/request_bloc_listener.dart';
import 'package:weather_app/core/init/network/network_manager.dart';
import '../../../../components/container/authentication_logo.dart';
import '../../../../components/elevated_button/authentication_button.dart';
import '../../../../components/input/default_textfield.dart';
import '../../../../core/base/state/base_state.dart';
import '../../../../core/base/view/base_view.dart';
import '../../../../core/constants/app/app_constants.dart';
import '../../../../core/constants/enums/locale_keys_enum.dart';
import '../../../../core/extension/context_extension.dart';
import '../../../../core/extension/string_extension.dart';
import '../../../../core/extension/themedata_extension.dart';
import '../../../../core/init/cache/locale_manager.dart';
import '../../../../core/init/language/locale_keys.g.dart';
import '../../../../core/init/navigation/navigation_service.dart';
import '../model/signup_request_model.dart';
import '../viewmodel/bloc/signup_view_model_bloc.dart';
import '../../../../core/constants/navigation/navigation_constants.dart';
import '../../../../core/init/network/bloc/request_bloc.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends BaseState<SignupView> {
  final emailFieldController = TextEditingController();
  final passwordFieldController = TextEditingController();


  bool isFieldsValid(){
    final emailFieldValid = RegExp(ApplicationConstants.EMAIL_REGEX).hasMatch(emailFieldController.text);
    final passwordFieldValid = RegExp(ApplicationConstants.STRONG_PASSWORD_REGEX).hasMatch(passwordFieldController.text);
    return emailFieldValid && passwordFieldValid;
  }

  @override
  Widget build(BuildContext context) {
    void Function() continuButtonEnableOnPressed(BuildContext context) {
      return (){
        final requestModel = SignupRequestModel(email: emailFieldController.text, password: passwordFieldController.text);
        final requestMethod = NetworkManagement.instance.putDio("/auth/signup", requestModel: requestModel, responseModel: SignupResponseModel.blank());
        context.read<RequestBloc<SignupResponseModel>>().add(SendRequestEvent(requestMethod: requestMethod));
      };
    }

    return BlocProvider(
      create:(context) => RequestBloc<SignupResponseModel>(),
      child: Builder(
        builder: (context) {
          return BaseView(
            onModelDispose: () {
              passwordFieldController.dispose();
              emailFieldController.dispose();
            },
            onConnectionBuilder: (context) {
              return RequestBlocListener<SignupResponseModel>(
                onLoading: (context) {
                  loadingShowDialog(context);
                },
                onJoiError: (context, error) {
                  showDialog(
                    context: context, 
                    builder:(context) {
                      return LoginInvalidInformationsDialog(
                        message: LocaleKeys.login_invalidInfos.locale,
                      );
                    },
                  );
                },
                onSuccess: (context, successObject) async {
                  await LocaleManager.instance.setStringValue(PreferencesKeys.x_access_key, successObject.data.jwtToken);
                  await LocaleManager.instance.setStringValue(PreferencesKeys.x_access_refresh_key, successObject.data.jwtRefreshToken);
                  NavigationService.instance.navigateToPage(path: NavigationConstants.HOME_VIEW);
                },
                onErrorOfAll: (context, error) {
                  Navigator.pop(context);
                },
                onServerError: (context, state) {
                  showInvalidInformationsDialog(context, LocaleKeys.serverError.locale);
                },
                onLogicalError: (context, error) {
                  showDialog(
                    context: context, 
                    builder:(context) {
                      return LoginInvalidInformationsDialog(
                        message: LocaleKeys.signup_userFoundErrorMessage.locale,
                      );
                    },
                  );
                },
                child: Scaffold(
                  body: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.only(top: context.getDynamicHeight(14), left: context.lowValue, right: context.lowValue),
                      child: SizedBox(
                            width: double.maxFinite,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // ybz logo
                                const AuthenticationPageLogo(),
                                // create account big title
                                Padding(
                                  padding: context.paddingNormalVertical,
                                  child: Text(LocaleKeys.signup_createAccount.locale, style: currentThemeData.currentAppFonts.bigTitle,),
                                ),
                                // email field
                                Padding(
                                  padding: context.paddingNormalVertical,
                                  child: BlocBuilder<SignupViewModelBloc, SignupViewModelState>(
                                    buildWhen: (previous, current) => previous.emailFieldErrorText != current.emailFieldErrorText,
                                    builder:(context, state) {
                                      return DefaultTextField(
                                      labelText: LocaleKeys.login_emailFieldHintText.locale,
                                      controller: emailFieldController,
                                      errorText: state.emailFieldErrorText,
                                      onChanged: (value) {
                                        if (!RegExp(ApplicationConstants.EMAIL_REGEX).hasMatch(value)) {
                                          context.read<SignupViewModelBloc>().add(ChangeEmailFieldErrorTextEvent(errorText: LocaleKeys.login_invalidEmailFormat.locale));
                                          context.read<SignupViewModelBloc>().add(SignupViewModelCountinueButtonChangeOnPressedEvent(onPressed: null));
                                        }
                                        else{
                                          context.read<SignupViewModelBloc>().add(ChangeEmailFieldErrorTextEvent(errorText: null));
                                          if(passwordFieldController.text.length >= 8){
                                            context.read<SignupViewModelBloc>().add(SignupViewModelCountinueButtonChangeOnPressedEvent(onPressed: continuButtonEnableOnPressed(context)));
                                          }
                                        }
                                      },
                                    );
                                    },
                                    )
                                ),
                                // password field
                                BlocBuilder<SignupViewModelBloc, SignupViewModelState>(
                                  buildWhen: (previous, current) => previous.passwordFieldObscuringText != current.passwordFieldObscuringText || previous.passwordFieldErrorText != current.passwordFieldErrorText,
                                  builder: (context, state) {
                                    return DefaultTextField(
                                      errorText: state.passwordFieldErrorText,
                                      onChanged: (value) {
                                        if(value.length < 8){
                                          context.read<SignupViewModelBloc>().add(ChangePasswordFieldErrorTextEvent(errorText: LocaleKeys.login_invalidPasswordFormat.locale));
                                            context.read<SignupViewModelBloc>().add(SignupViewModelCountinueButtonChangeOnPressedEvent(onPressed: null));
                                        }
                                        else{
                                          context.read<SignupViewModelBloc>().add(ChangePasswordFieldErrorTextEvent(errorText: null));
                                          if(RegExp(ApplicationConstants.EMAIL_REGEX).hasMatch(emailFieldController.text)){
                                            context.read<SignupViewModelBloc>().add(SignupViewModelCountinueButtonChangeOnPressedEvent(onPressed: continuButtonEnableOnPressed(context)));
                                          }
                                        }
                                      },
                                      labelText: LocaleKeys.login_passwordFieldHintText.locale,
                                      controller: passwordFieldController,
                                      obscureText: state.passwordFieldObscuringText,
                                      suffixIcon: !state.passwordFieldObscuringText ? Icons.lock_open_rounded :  Icons.lock_outline_rounded,
                                      onSuffix: state.passwordFieldObscuringText ? ()=> context.read<SignupViewModelBloc>().add(SignupViewModelPasswordFieldChangeObscureTextFieldEvent(obscuringText: false)) : ()=> context.read<SignupViewModelBloc>().add(SignupViewModelPasswordFieldChangeObscureTextFieldEvent(obscuringText: true)),
                                    );
                                  },
                                ),
                              // continue button
                              BlocBuilder<SignupViewModelBloc, SignupViewModelState>(
                                buildWhen: (previous, current) => previous.continueButtonOnPressed != current.continueButtonOnPressed,
                                builder: (context, state) {
                                  return AuthenticationButton(title: LocaleKeys.signup_continue.locale, onPressed:  state.continueButtonOnPressed,);
                                },
                              ),
                
                              // go to login text button
                              Padding(
                                padding:  EdgeInsets.only(top: context.mediumValue),
                                child: RichText(
                                  text: TextSpan(text: LocaleKeys.signup_hasAccount.locale, style: currentThemeData.currentAppFonts.cardSubTitleLocation, children: [
                                    TextSpan(
                                      text: LocaleKeys.signup_goToLogin.locale,
                                      style: currentThemeData.currentAppFonts.cardSubTitleLocation.copyWith(color: currentThemeData.colorScheme.primary),
                                      recognizer: TapGestureRecognizer()..onTap = ()=> NavigationService.instance.navigateToPageClear(path: NavigationConstants.LOGIN_VIEW),
                                    ),
                                  ]),
                                ),
                              ),
                              ],
                            ),
                          ),
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

