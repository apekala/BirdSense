

import 'package:bird_sense/data/forecast/models/hourly_weather.dart';

class HourlyWeatherEntity{
final double temperature;
final String icon;

  HourlyWeatherEntity({required this.temperature, required this.icon});

   static HourlyWeatherEntity fromModel(HourlyWeather model) {
    return HourlyWeatherEntity(
      temperature: model.temperature,
      icon: model.icon,
      );


   }
}