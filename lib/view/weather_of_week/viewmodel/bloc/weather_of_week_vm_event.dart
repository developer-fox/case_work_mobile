part of 'weather_of_week_vm_bloc.dart';

@immutable
abstract class WeatherOfWeekVmEvent {}

class ChangePanelWeatherModelEvent extends WeatherOfWeekVmEvent {
  final SingleDayWeatherModel weatherModel;
  ChangePanelWeatherModelEvent({
    required this.weatherModel,
  });
}
