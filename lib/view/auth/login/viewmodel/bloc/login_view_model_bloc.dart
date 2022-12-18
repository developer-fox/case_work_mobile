import 'package:bloc/bloc.dart';

part 'login_view_model_event.dart';
part 'login_view_model_state.dart';

class LoginViewModelBloc extends Bloc<LoginViewModelEvent, LoginViewModelDefaultState> {
  LoginViewModelBloc() : super(LoginViewModelDefaultState(continueButtonOnPressed: null, passwordFieldObscuringText:  true, emailFieldErrorText: null, passwordFieldErrorText: null)) {
    on<LoginViewModelCountinueButtonChangeOnPressedEvent>(_onChangeContinueButtonOnPressedEvent);
    on<LoginViewModelPasswordFieldChangeObscureTextFieldEvent>(_onPasswordFieldChangeObscureTextEvent);
    on<ChangeEmailFieldErrorTextEvent>(_onChangeEmailFieldErrorTextEvent);
    on<ChangePasswordFieldErrorTextEvent>(_onChangePasswordFieldErrorTextEvent);
  }

  void _onChangeContinueButtonOnPressedEvent(LoginViewModelCountinueButtonChangeOnPressedEvent event, Emitter<LoginViewModelDefaultState> emit){
    emit(LoginViewModelDefaultState(continueButtonOnPressed: event.onPressed, passwordFieldObscuringText: state.passwordFieldObscuringText, emailFieldErrorText: state.emailFieldErrorText, passwordFieldErrorText: state.passwordFieldErrorText));
  }

  void _onPasswordFieldChangeObscureTextEvent(LoginViewModelPasswordFieldChangeObscureTextFieldEvent event, Emitter<LoginViewModelDefaultState> emit){
    emit(LoginViewModelDefaultState(continueButtonOnPressed: state.continueButtonOnPressed, passwordFieldObscuringText: event.obscuringText, emailFieldErrorText: state.emailFieldErrorText, passwordFieldErrorText: state.passwordFieldErrorText));
  }

  void _onChangePasswordFieldErrorTextEvent(ChangePasswordFieldErrorTextEvent event, Emitter<LoginViewModelDefaultState> emit){
    emit(LoginViewModelDefaultState(continueButtonOnPressed: state.continueButtonOnPressed, passwordFieldObscuringText: state.passwordFieldObscuringText, emailFieldErrorText: state.emailFieldErrorText, passwordFieldErrorText: event.errorText));
  }
  void _onChangeEmailFieldErrorTextEvent(ChangeEmailFieldErrorTextEvent event, Emitter<LoginViewModelDefaultState> emit){
    emit(LoginViewModelDefaultState(continueButtonOnPressed: state.continueButtonOnPressed, passwordFieldObscuringText: state.passwordFieldObscuringText, emailFieldErrorText: event.errorText, passwordFieldErrorText: state.passwordFieldErrorText));
  }


}

