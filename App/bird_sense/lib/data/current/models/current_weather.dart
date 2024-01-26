import 'dart:convert';

import 'package:collection/collection.dart';

class CurrentWeather {
  final double lastUpdatedEpoch;
  final double temperatureCelsius;
  final double temperatureFahrenheit;
  final double windMph;
  final double windKph;
  final String windDirection;
  final double humidity;
  final double cloudiness;
  final double uv;
  final double fellTemperatureCelcius;
  final String conditionText;
  final String conditionIcon;
  final double windDegree;
  final double pressure;
  CurrentWeather({
    required this.lastUpdatedEpoch,
    required this.temperatureCelsius,
    required this.temperatureFahrenheit,
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

  CurrentWeather copyWith({
    double? lastUpdatedEpoch,
    double? temperatureCelsius,
    double? temperatureFahrenheit,
    double? windMph,
    double? windKph,
    String? windDirection,
    double? humidity,
    double? cloudiness,
    double? uv,
    double? fellTemperatureCelcius,
    String? conditionText,
    String? conditionIcon,
    double? windDegree,
    double? pressure
  }) {
    return CurrentWeather(
      lastUpdatedEpoch: lastUpdatedEpoch ?? this.lastUpdatedEpoch,
      temperatureCelsius: temperatureCelsius ?? this.temperatureCelsius,
      temperatureFahrenheit: temperatureFahrenheit ?? this.temperatureFahrenheit,
      windMph: windMph ?? this.windMph,
      windKph: windKph ?? this.windKph,
      windDirection: windDirection ?? this.windDirection,
      humidity: humidity ?? this.humidity,
      cloudiness: cloudiness ?? this.cloudiness,
      uv: uv ?? this.uv,
      fellTemperatureCelcius: fellTemperatureCelcius?? this.fellTemperatureCelcius,
      conditionText: conditionText?? this.conditionText,
      conditionIcon: conditionIcon?? this.conditionIcon,
      windDegree: windDegree?? this.windDegree,
      pressure: pressure ?? this.pressure,
    );
  }

  // factory CurrentWeather.fromJson(Map<String, dynamic> json) {
  //   return CurrentWeather(
  //     lastUpdatedEpoch: json['current']['last_updated_epoch'],
  //     temperatureCelsius: json['current']['temp_c'],
  //     temperatureFahrenheit: json['current']['temp_f'],
  //     windMph: json['current']['wind_mph'],
  //     windKph: json['current']['wind_kph'],
  //     windDirection: json['current']['wind_dir'],
  //     humidity: json['current']['humidity'],
  //     cloudiness: json['current']['cloud'],
  //     uv: json['current']['uv'],
  //     fellTemperatureCelcius: json['current']['feelslike_c'],
  //     conditionText: json['current']['condition']['text'],
  //     conditionIcon: json['current']['condition']['icon'],
  //     windDegree: json['current']['wind_degree'],
  //     pressure: json['current']['pressure_mb'],
  //   );
  // }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'last_updated_epoch': lastUpdatedEpoch,
      'temp_c': temperatureCelsius,
      'temp_f': temperatureFahrenheit,
      'wind_mph': windMph,
      'wind_kph': windKph,
      'wind_dir': windDirection,
      'humidity': humidity,
      'cloud': cloudiness,
      'uv': uv,
      'feelslike_c': fellTemperatureCelcius,
      //'condition': condition.map((x) => x.toMap()).toList(),
    };
  }
  factory CurrentWeather.fromMap(Map<String, dynamic> map) {
    return CurrentWeather(
      lastUpdatedEpoch: map['last_updated_epoch']?.toDouble() ?? 0.0,
      temperatureCelsius: map['temp_c']?.toDouble() ?? 0.0,
      temperatureFahrenheit: map['temp_f']?.toDouble() ?? 0.0,
      windMph: map['wind_mph']?.toDouble() ?? 0.0,
      windKph: map['wind_kph']?.toDouble() ?? 0.0,
      windDirection: map['wind_dir'] ?? '',
      humidity: map['humidity']?.toDouble() ?? 0.0,
      cloudiness: map['cloud']?.toDouble() ?? 0.0,
      uv: map['uv']?.toDouble() ?? 0.0,
      fellTemperatureCelcius: map['feelslike_c']?.toDouble() ?? 0.0,
      conditionText: map['condition']['text'] ?? '',
     conditionIcon: map['condition']['icon'] ?? '',
     windDegree: map['wind_degree']?.toDouble() ?? 0.0,
      pressure: map['pressure_mb']?.toDouble() ?? 0.0,
    );
  }


  String toJson() => json.encode(toMap());

  factory CurrentWeather.fromJson(String source) => CurrentWeather.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CurrentWeather(lastUpdatedEpoch: $lastUpdatedEpoch, temperatureCelsius: $temperatureCelsius, temperatureFahrenheit: $temperatureFahrenheit, windMph: $windMph, windKph: $windKph, windDirection: $windDirection, humidity: $humidity, cloudiness: $cloudiness, uv: $uv, fellTemperatureCelcius: $fellTemperatureCelcius, conditionText: $conditionText, conditionIcon: $conditionIcon, windDegree: $windDegree, pressure: $pressure,)';
  }

  @override
  bool operator ==(covariant CurrentWeather other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;
  
    return 
      other.lastUpdatedEpoch == lastUpdatedEpoch &&
      other.temperatureCelsius == temperatureCelsius &&
      other.temperatureFahrenheit == temperatureFahrenheit &&
      other.windMph == windMph &&
      other.windKph == windKph &&
      other.windDirection == windDirection &&
      other.humidity == humidity &&
      other.cloudiness == cloudiness &&
      other.uv == uv &&
      other.fellTemperatureCelcius == fellTemperatureCelcius&&
      other.conditionText == conditionText&&
      other.conditionIcon == conditionIcon&&
      other.windDegree == windDegree;
  }

  @override
  int get hashCode {
    return lastUpdatedEpoch.hashCode ^
      temperatureCelsius.hashCode ^
      temperatureFahrenheit.hashCode ^
      windMph.hashCode ^
      windKph.hashCode ^
      windDirection.hashCode ^
      humidity.hashCode ^
      cloudiness.hashCode ^
      uv.hashCode ^
      fellTemperatureCelcius.hashCode^
      conditionText.hashCode^
      conditionIcon.hashCode^
      windDegree.hashCode;
  }
}