import 'package:bloc/bloc.dart';
part 'create_activity_vm_event.dart';
part 'create_activity_vm_state.dart';

class CreateActivityVmBloc extends Bloc<CreateActivityVmEvent, CreateActivityVmState> {
  final CreateActivityVmState initialState;
  CreateActivityVmBloc({required this.initialState}) : super(initialState) {
    on<ChangeSelectedCityEvent>(_onChangeSelectedCityEvent);
    on<ChangeSaveButtonOnPressedEvent>(_onChangeSaveButtonOnPressed);
    on<ChangeSelectedDateEvent>(_onChangeSelectedDateEvent);
    on<ClearStates>((event, emit) async {
      emit(CreateActivityVmState(currentFeedbackType: null, continuButtonOnPressed: null));
    },);
  }

  _onChangeSelectedCityEvent(ChangeSelectedCityEvent event, Emitter<CreateActivityVmState> emit){
    emit(CreateActivityVmState(currentFeedbackType: event.city, continuButtonOnPressed:  state.continuButtonOnPressed, selectedDate: state.selectedDate));
  }

  _onChangeSaveButtonOnPressed(ChangeSaveButtonOnPressedEvent event, Emitter<CreateActivityVmState> emit){
    emit(CreateActivityVmState(currentFeedbackType: state.currentFeedbackType, continuButtonOnPressed:  event.onPressed, selectedDate: state.selectedDate));
  }

  _onChangeSelectedDateEvent(ChangeSelectedDateEvent event, Emitter<CreateActivityVmState> emit){
    emit(CreateActivityVmState(currentFeedbackType: state.currentFeedbackType, continuButtonOnPressed:  state.continuButtonOnPressed, selectedDate: event.selectedDate));
  }

}