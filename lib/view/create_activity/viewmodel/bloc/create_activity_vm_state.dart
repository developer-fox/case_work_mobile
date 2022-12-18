part of 'create_activity_vm_bloc.dart';

class CreateActivityVmState {
  final String? currentFeedbackType;
  final void Function()? continuButtonOnPressed;
  final DateTime? selectedDate;
  CreateActivityVmState({
    required this.currentFeedbackType,
    required this.continuButtonOnPressed,
    this.selectedDate,
  });
}
