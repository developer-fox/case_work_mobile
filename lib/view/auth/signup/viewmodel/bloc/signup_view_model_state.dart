part of 'signup_view_model_bloc.dart';

class SignupViewModelState {
  final bool passwordFieldObscuringText;
  final void Function()? continueButtonOnPressed;
  final String? emailFieldErrorText;
  final String? passwordFieldErrorText;

  SignupViewModelState({
    required this.passwordFieldObscuringText,
    this.continueButtonOnPressed,
    required this.emailFieldErrorText,
    required this.passwordFieldErrorText,
  });

}
