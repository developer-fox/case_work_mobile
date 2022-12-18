part of 'signup_view_model_bloc.dart';

@immutable
abstract class SignupViewModelEvent {}

class SignupViewModelPasswordFieldChangeObscureTextFieldEvent extends SignupViewModelEvent{
  final bool obscuringText;
  SignupViewModelPasswordFieldChangeObscureTextFieldEvent({
    required this.obscuringText,
  });
}

class SignupViewModelCountinueButtonChangeOnPressedEvent extends SignupViewModelEvent {
  final void Function()? onPressed;
  SignupViewModelCountinueButtonChangeOnPressedEvent({
    this.onPressed,
  });
}

class ChangePasswordFieldErrorTextEvent extends SignupViewModelEvent {
  final String? errorText;
  ChangePasswordFieldErrorTextEvent({
    required this.errorText,
  });
}
class ChangeEmailFieldErrorTextEvent extends SignupViewModelEvent {
  final String? errorText;
  ChangeEmailFieldErrorTextEvent({
    required this.errorText,
  });
}
