import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:weather_app/view/weather_of_week/model/single_day_weather_model.dart';
part 'weather_of_week_vm_event.dart';
part 'weather_of_week_vm_state.dart';

class WeatherOfWeekVmBloc extends Bloc<WeatherOfWeekVmEvent, WeatherOfWeekVmState> {
  WeatherOfWeekVmBloc() : super(WeatherOfWeekVmState()) {
    on<ChangePanelWeatherModelEvent>((event, emit) {
      emit(WeatherOfWeekVmState(panelWeatherModel: event.weatherModel));
    });
  }
}