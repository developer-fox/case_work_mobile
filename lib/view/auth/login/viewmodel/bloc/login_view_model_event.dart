part of 'login_view_model_bloc.dart';

abstract class LoginViewModelEvent {}

class LoginViewModelCountinueButtonChangeOnPressedEvent extends LoginViewModelEvent {
  final void Function()? onPressed;
  LoginViewModelCountinueButtonChangeOnPressedEvent({
    this.onPressed,
  });
}

class LoginViewModelPasswordFieldChangeObscureTextFieldEvent extends LoginViewModelEvent {
  final bool obscuringText;
  LoginViewModelPasswordFieldChangeObscureTextFieldEvent({
    required this.obscuringText,
  });
}
class ChangePasswordFieldErrorTextEvent extends LoginViewModelEvent {
  final String? errorText;
  ChangePasswordFieldErrorTextEvent({
    required this.errorText,
  });
}
class ChangeEmailFieldErrorTextEvent extends LoginViewModelEvent {
  final String? errorText;
  ChangeEmailFieldErrorTextEvent({
    required this.errorText,
  });
}
