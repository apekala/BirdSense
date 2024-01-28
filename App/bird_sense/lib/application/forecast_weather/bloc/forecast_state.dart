part of 'forecast_bloc.dart';

@immutable
sealed class ForecastWeatherState {}

class ForecastWeatherInitial extends ForecastWeatherState {}

class ForecastWeatherLoading extends ForecastWeatherState {
  final List<ForecastWeatherEntity>? lastWeather;
  final List<HourlyWeatherEntity>? lastHourly;

  ForecastWeatherLoading({
    this.lastWeather,
    this.lastHourly
  });
}

class ForecastWeatherLoaded extends ForecastWeatherState {
  final List<ForecastWeatherEntity> weather;
  final List<HourlyWeatherEntity>? hourly;

  ForecastWeatherLoaded({
    required this.weather,
    required this.hourly
  });
}
