import 'package:bird_sense/application/current_weather/current_weather_entity.dart';
import 'package:bird_sense/data/current/current_weather_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CurrentWeatherBloc
    extends Bloc<QueryForLocationEvent, CurrentWeatherState> {
  final CurrentWeatherRepository repository;

  CurrentWeatherBloc({required this.repository})
      : super(CurrentWeatherInitial()) {
    on<QueryForLocationEvent>((event, emit) async {
      final location = event.location;

      final state = this.state;
      if (state is CurrentWeatherLoaded) {
        emit(CurrentWeatherLoading(lastWeather: state.weather));
      } else {
        emit(CurrentWeatherLoading());
      }

      final weather = await repository.getWeather(location);

      if (weather != null) {
        final weatherEntity = CurrentWeatherEntity.fromModel(weather);

        emit(CurrentWeatherLoaded(weather: weatherEntity));
      } else {
        emit(CurrentWeatherInitial());
      }
    });
  }
}

sealed class CurrentWeatherState {}

class CurrentWeatherInitial extends CurrentWeatherState {}

class CurrentWeatherLoading extends CurrentWeatherState {
  final CurrentWeatherEntity? lastWeather;

  CurrentWeatherLoading({
    this.lastWeather,
  });
}

class CurrentWeatherLoaded extends CurrentWeatherState {
  final CurrentWeatherEntity weather;

  CurrentWeatherLoaded({
    required this.weather,
  });
}

class QueryForLocationEvent {
  final String location;

  QueryForLocationEvent({
    required this.location,
  });
}