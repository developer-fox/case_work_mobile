import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'signup_view_model_event.dart';
part 'signup_view_model_state.dart';

class SignupViewModelBloc extends Bloc<SignupViewModelEvent, SignupViewModelState> {
  SignupViewModelBloc() : super(SignupViewModelState(passwordFieldObscuringText: true, passwordFieldErrorText: null, emailFieldErrorText: null)) {
    on<SignupViewModelPasswordFieldChangeObscureTextFieldEvent>(_onPasswordFieldChangeObscureTextEvent);
    on<SignupViewModelCountinueButtonChangeOnPressedEvent>(_onChangeContinueButtonOnPressedEvent);
    on<ChangeEmailFieldErrorTextEvent>(_onChangeEmailFieldErrorTextEvent);
    on<ChangePasswordFieldErrorTextEvent>(_onChangePasswordFieldErrorTextEvent);
  }

  
  void _onPasswordFieldChangeObscureTextEvent(SignupViewModelPasswordFieldChangeObscureTextFieldEvent event, Emitter<SignupViewModelState> emit){
    emit(SignupViewModelState(continueButtonOnPressed: state.continueButtonOnPressed, passwordFieldObscuringText: event.obscuringText, emailFieldErrorText: state.emailFieldErrorText, passwordFieldErrorText: state.passwordFieldErrorText));

  }

  void _onChangeContinueButtonOnPressedEvent(SignupViewModelCountinueButtonChangeOnPressedEvent event, Emitter<SignupViewModelState> emit){
    emit(SignupViewModelState(continueButtonOnPressed: event.onPressed, passwordFieldObscuringText: state.passwordFieldObscuringText, emailFieldErrorText: state.emailFieldErrorText, passwordFieldErrorText: state.passwordFieldErrorText));

  }

  void _onChangePasswordFieldErrorTextEvent(ChangePasswordFieldErrorTextEvent event, Emitter<SignupViewModelState> emit){
    emit(SignupViewModelState(continueButtonOnPressed: state.continueButtonOnPressed, passwordFieldObscuringText: state.passwordFieldObscuringText, emailFieldErrorText: state.emailFieldErrorText, passwordFieldErrorText: event.errorText));
  }
  void _onChangeEmailFieldErrorTextEvent(ChangeEmailFieldErrorTextEvent event, Emitter<SignupViewModelState> emit){
    emit(SignupViewModelState(continueButtonOnPressed: state.continueButtonOnPressed, passwordFieldObscuringText: state.passwordFieldObscuringText, emailFieldErrorText: event.errorText, passwordFieldErrorText: state.passwordFieldErrorText));
  }


}
