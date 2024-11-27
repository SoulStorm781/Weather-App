import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather/weather.dart';

import 'package:weather_app/Api_data/api.dart';

part 'weather_bloc_event.dart';
part 'weather_bloc_state.dart';

class WeatherBlocBloc extends Bloc<WeatherBlocEvent, WeatherBlocState> {
  WeatherBlocBloc() : super(WeatherBlocInitial()) {
    on<FetchWeather>((event, emit) async {
      emit(WeatherBlocLoading());
      try {
        WeatherFactory wf = WeatherFactory(API_KEY, language: Language.ENGLISH);
        Weather weather = await wf.currentWeatherByCityName(event.cityName);

        if (weather.temperature == null || weather.weatherMain == null) {
          throw Exception("Incomplete weather data");
        }

        emit(WeatherBlocSuccess(weather));
      } catch (e) {
        if (e.toString().contains("404")) {
          emit(
              WeatherBlocFailure(message: "City not found. Please try again."));
        } else {
          emit(WeatherBlocFailure(
              message: "Failed to fetch weather. Check your connection."));
        }
      }
    });
  }
}
