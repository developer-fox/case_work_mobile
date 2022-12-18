part of 'create_activity_vm_bloc.dart';

abstract class CreateActivityVmEvent {}

class ChangeSelectedCityEvent extends CreateActivityVmEvent{
  final String? city;
  ChangeSelectedCityEvent({
    required this.city,
  });
}

class ChangeSaveButtonOnPressedEvent extends CreateActivityVmEvent {
  final void Function()? onPressed;
  ChangeSaveButtonOnPressedEvent({
    required this.onPressed,
  });
}
class ChangeSelectedDateEvent extends CreateActivityVmEvent {
  final DateTime? selectedDate;
  ChangeSelectedDateEvent({
    required this.selectedDate,
  });
}

class CheckFields extends CreateActivityVmEvent {
  CheckFields();
}

class ClearStates extends CreateActivityVmEvent {
  ClearStates();
}
