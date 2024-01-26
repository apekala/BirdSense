

import 'package:bird_sense/application/core/temperature_value_object.dart';
import 'package:bird_sense/application/core/wind_value_object.dart';
import 'package:bird_sense/data/current/models/current_weather.dart';

class CurrentWeatherEntity {
  final TemperatureValueObject temperatureC;
  final TemperatureValueObject temperatureF;
  final WindValueObject windMph;
  final WindValueObject windKph;
  final String windDirection;
  final double humidity;
  final double cloudiness;
  final double uv;
  final double fellTemperatureCelcius;
  final String conditionText;
  final String conditionIcon;
  final double windDegree;
  final double pressure;

  CurrentWeatherEntity({
    required this.temperatureC,
    required this.temperatureF,
    required this.windMph,
    required this.windKph,
    required this.windDirection,
    required this.humidity,
    required this.cloudiness,
    required this.uv,
    required this.fellTemperatureCelcius,
    required this.conditionText,
    required this.conditionIcon,
    required this.windDegree,
    required this.pressure
    
  });

  static CurrentWeatherEntity fromModel(CurrentWeather model) {
    return CurrentWeatherEntity(
      temperatureC: TemperatureValueObject(
        unit: TemperatureUnit.celsius,
        value: model.temperatureCelsius,
      ),
      temperatureF: TemperatureValueObject(
        unit: TemperatureUnit.fahrenheit,
        value: model.temperatureFahrenheit,
      ),
      windMph: WindValueObject(value: model.windMph, unit: WindUnit.milesPerHour),
      windKph: WindValueObject(unit: WindUnit.kilometersPerHour, value: model.windKph),
      windDirection: model.windDirection,
      humidity: model.humidity,
      cloudiness: model.cloudiness,
      uv: model.uv,
      fellTemperatureCelcius: model.fellTemperatureCelcius,
      conditionText: model.conditionText,
      conditionIcon: model.conditionIcon,
      windDegree: model.windDegree,
      pressure: model.pressure,
    );
  }
}