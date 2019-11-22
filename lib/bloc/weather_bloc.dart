import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_tutorial/data/weather_repository.dart';
import './bloc.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc(this.weatherRepository);

  @override
  WeatherState get initialState => WeatherInitial();

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    yield WeatherLoading();
    if (event is GetWeather) {
      try {
        final weather = await weatherRepository.fetchWeather(event.cityName);
        yield WeatherLoaded(weather);
      } on Error {
        yield WeatherError("Could not fetchWeather!");
      }
    } else if (event is GetDetailedWeather) {
      try{
        final weather = await weatherRepository.fetchDetailedWeather(event.cityName);
        yield WeatherLoaded(weather);
      }on Error{
        yield WeatherError("Could not fetchDetailedWeather");
      }
    }
  }
}
