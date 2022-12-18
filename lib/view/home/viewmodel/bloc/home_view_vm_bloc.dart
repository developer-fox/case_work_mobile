import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
part 'home_view_vm_event.dart';
part 'home_view_vm_state.dart';

class HomeViewVmBloc extends Bloc<HomeViewVmEvent, HomeViewVmState> {
  HomeViewVmBloc() : super(HomeViewVmState(focusedItemIndex: null)) {
    on<ChangeCurrentFocusedIndex>(_onChangeFocusedEvent);
  }

  _onChangeFocusedEvent(ChangeCurrentFocusedIndex event, Emitter<HomeViewVmState> emit){
    emit(HomeViewVmState(focusedItemIndex: event.newIndex));
  }
}