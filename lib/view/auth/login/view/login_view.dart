
import 'package:flutter/gestures.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/components/dialog/loading_show_dialog.dart';
import 'package:weather_app/components/dialog/login_invalid_informations_dialog.dart';
import 'package:weather_app/core/base/model/request_bloc_listener.dart';
import 'package:weather_app/core/base/model/unmodified_response_model.dart';
import 'package:weather_app/core/constants/enums/locale_keys_enum.dart';
import 'package:weather_app/core/init/network/network_manager.dart';
import 'package:weather_app/view/auth/login/model/login_model.dart';
import '../../../../components/container/authentication_logo.dart';
import '../../../../components/elevated_button/authentication_button.dart';
import '../../../../components/input/default_textfield.dart';
import '../../../../core/base/state/base_state.dart';
import '../../../../core/constants/navigation/navigation_constants.dart';
import '../../../../core/extension/context_extension.dart';
import '../../../../core/extension/string_extension.dart';
import '../../../../core/extension/themedata_extension.dart';
import '../../../../core/init/cache/locale_manager.dart';
import '../../../../core/init/language/locale_keys.g.dart';
import '../../../../core/init/navigation/navigation_service.dart';
import '../../../../core/init/network/bloc/request_bloc.dart';
import '../viewmodel/bloc/login_view_model_bloc.dart';
import '../../../../core/base/view/base_view.dart';
import '../../../../core/constants/app/app_constants.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends BaseState<LoginView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void Function()  loginButtonEnabledOnPressed(BuildContext context) {
    return (){
      final requestModel = LoginRequestModel(email: emailController.text, password: passwordController.text);
      final requestMethod = NetworkManagement.instance.postDio("/auth/login",requestModel: requestModel, responseModel: LoginResponseModel.blank());
      context.read<RequestBloc<LoginResponseModel>>().add(SendRequestEvent(requestMethod: requestMethod));
    };
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RequestBloc<LoginResponseModel>(),
      child: Builder(
        builder: (context) {
          return BaseView(
            onModelDispose: () {
              emailController.dispose();
              passwordController.dispose();
            },
            onModelReady: () {},
            onConnectionBuilder: (context) {
              return RequestBlocListener<LoginResponseModel>(
                    onSuccess: (context, successObject) async {
                      await LocaleManager.instance.setStringValue(PreferencesKeys.x_access_key, successObject.data.jwtToken);
                      await LocaleManager.instance.setStringValue(PreferencesKeys.x_access_refresh_key, successObject.data.jwtRefreshToken);
                      NavigationService.instance.navigateToPageClear(path: NavigationConstants.HOME_VIEW);
                    },
                    onErrorOfAll: (context, error) {
                      Navigator.pop(context);
                    },
                    onDataNotFoundError: (context, error) {
                      showDialog(
                        context: context, 
                        builder:(context) {
                          return LoginInvalidInformationsDialog(message: LocaleKeys.login_notFoundAccount.locale);
                        },
                      );
                    },
                    onServerError: (context, state) {
                      showDialog(
                        context: context, 
                        builder:(context) {
                          return LoginInvalidInformationsDialog(message: LocaleKeys.serverError.locale);
                        },
                      );
                    },
                    onLogicalError: (context, error) {
                      showDialog(
                        context: context, 
                        builder:(context) {
                          return LoginInvalidInformationsDialog(message: LocaleKeys.login_wrongPassword.locale);
                        },
                      );
                    },
                    onLoading: (context) {
                      loadingShowDialog(context);
                    },
                    child: Scaffold(
                      body: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: BlocProvider(
                          create: (context) => RequestBloc<UnmodifiedResponseDataModel>(),
                          child: Builder(builder: (context) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: context.getDynamicHeight(14),
                                  horizontal: context.lowValue),
                              child: SizedBox(
                                width: context.getDynamicWidth(100),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // logo
                                    const AuthenticationPageLogo(),
                                    // welcome big title
                                    Padding(
                                      padding: context.paddingNormalVertical,
                                      child: Text(LocaleKeys.login_bigTitle.locale, style: currentThemeData.currentAppFonts.bigTitle,),
                                    ),
                  
                                    // page dummy description
                                    Text(
                                      LocaleKeys.login_pageSubtitle.locale,
                                      style: currentThemeData
                                          .currentAppFonts.dateDayTitleStyle,
                                      textAlign: TextAlign.center,
                                    ),
                                    // email field
                                    Padding(
                                      padding: context.paddingNormalVertical,
                                      child: BlocBuilder<LoginViewModelBloc, LoginViewModelDefaultState>(
                                        buildWhen: (previous, current) => previous.emailFieldErrorText != current.emailFieldErrorText,
                                        builder:(context, state) {
                                          return DefaultTextField(
                                          labelText: LocaleKeys.login_emailFieldHintText.locale,
                                          controller: emailController,
                                          errorText: state.emailFieldErrorText,
                                          onChanged: (value) {
                                            if (!RegExp(ApplicationConstants.EMAIL_REGEX).hasMatch(value)) {
                                              context.read<LoginViewModelBloc>().add(ChangeEmailFieldErrorTextEvent(errorText: LocaleKeys.login_invalidEmailFormat.locale));
                                              context.read<LoginViewModelBloc>().add(LoginViewModelCountinueButtonChangeOnPressedEvent(onPressed: null));
                                            }
                                            else{
                                              if(passwordController.text.length >= 8){
                                                context.read<LoginViewModelBloc>().add(LoginViewModelCountinueButtonChangeOnPressedEvent(onPressed: loginButtonEnabledOnPressed(context)));
                                              }
                                              context.read<LoginViewModelBloc>().add(ChangeEmailFieldErrorTextEvent(errorText: null));
                                            }
                                          },
                                        );
                                        },
                                        )
                                    ),
                                    // password field
                                    BlocBuilder<LoginViewModelBloc, LoginViewModelDefaultState>(
                                      buildWhen: (previous, current) => previous.passwordFieldObscuringText != current.passwordFieldObscuringText || previous.passwordFieldErrorText != current.passwordFieldErrorText,
                                      builder: (context, state) {
                                        return DefaultTextField(
                                          errorText: state.passwordFieldErrorText,
                                          onChanged: (value) {
                                            if(value.length < 8){
                                              context.read<LoginViewModelBloc>().add(ChangePasswordFieldErrorTextEvent(errorText: LocaleKeys.login_invalidPasswordFormat.locale));
                                              context.read<LoginViewModelBloc>().add(LoginViewModelCountinueButtonChangeOnPressedEvent(onPressed: null));
                                            }
                                            else{
                                              context.read<LoginViewModelBloc>().add(ChangePasswordFieldErrorTextEvent(errorText: null));
                                              if(RegExp(ApplicationConstants.EMAIL_REGEX).hasMatch(emailController.text)){
                                                context.read<LoginViewModelBloc>().add(LoginViewModelCountinueButtonChangeOnPressedEvent(onPressed: loginButtonEnabledOnPressed(context)));
                                              }
                                            }
                                          },
                                          labelText: LocaleKeys.login_passwordFieldHintText.locale,
                                          controller: passwordController,
                                          obscureText: state.passwordFieldObscuringText,
                                          suffixIcon: !state.passwordFieldObscuringText ? Icons.lock_open_rounded :  Icons.lock_outline_rounded,
                                          onSuffix: state.passwordFieldObscuringText ? ()=> context.read<LoginViewModelBloc>().add(LoginViewModelPasswordFieldChangeObscureTextFieldEvent(obscuringText: false)) : ()=> context.read<LoginViewModelBloc>().add(LoginViewModelPasswordFieldChangeObscureTextFieldEvent(obscuringText: true)),
                                        );
                                      },
                                    ),
                  
                                    // continue button
                                    Padding(
                                      padding: EdgeInsets.only(top: context.lowValue),
                                      child: BlocBuilder<LoginViewModelBloc,
                                          LoginViewModelDefaultState>(
                                          buildWhen: (previous, current) => previous.continueButtonOnPressed != current.continueButtonOnPressed,
                                        builder: (context, state) {
                                          return AuthenticationButton(
                                            title: LocaleKeys.login_continue.locale,
                                            onPressed: state.continueButtonOnPressed,
                                          );
                                        },
                                      ),
                                    ),
                  
                                    Padding(
                                      padding:  EdgeInsets.only(top: context.mediumValue),
                                      child: RichText(
                                        text: TextSpan(text: LocaleKeys.login_hasntAccount.locale, style: currentThemeData.currentAppFonts.cardSubTitleLocation, children: [
                                          TextSpan(
                                            text: LocaleKeys.login_createAccount.locale,
                                            style: currentThemeData.currentAppFonts.cardSubTitleLocation.copyWith(color: currentThemeData.colorScheme.primary),
                                            recognizer: TapGestureRecognizer()..onTap = ()=> NavigationService.instance.navigateToPageClear(path: NavigationConstants.SIGNUP_VIEW),
                                          ),
                                        ]),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
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
