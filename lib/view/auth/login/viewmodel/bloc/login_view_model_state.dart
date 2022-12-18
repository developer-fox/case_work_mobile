part of 'login_view_model_bloc.dart';

abstract class LoginViewModelState {}

class LoginViewModelDefaultState extends LoginViewModelState {
  final void Function()? continueButtonOnPressed;
  final bool passwordFieldObscuringText;
  final String? emailFieldErrorText;
  final String? passwordFieldErrorText;
  LoginViewModelDefaultState({
    required this.continueButtonOnPressed,
    required this.passwordFieldObscuringText,
    required this.emailFieldErrorText,
    required this.passwordFieldErrorText,
  });
}