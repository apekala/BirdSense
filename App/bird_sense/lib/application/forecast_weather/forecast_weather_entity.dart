



import 'package:bird_sense/data/forecast/models/forecastWeather.dart';

class ForecastWeatherEntity{
final double maxTemperature;
final double minTemperature;
final int humidity;
final String icon;

  ForecastWeatherEntity({required this.maxTemperature, required this.minTemperature, required this.humidity, required this.icon});

   static ForecastWeatherEntity fromModel(ForecastWeather model) {
    return ForecastWeatherEntity(
      maxTemperature: model.maxTemp,
      minTemperature: model.minTemp,
      humidity: model.humidity,
      icon: model.conditionIcon,
      );


   }
}