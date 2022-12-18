part of 'home_view_vm_bloc.dart';

@immutable
abstract class HomeViewVmEvent {}

class ChangeCurrentFocusedIndex extends HomeViewVmEvent {
  final int? newIndex;
  ChangeCurrentFocusedIndex({
    required this.newIndex,
  });
}
