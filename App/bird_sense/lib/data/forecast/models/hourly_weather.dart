// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

List<HourlyWeather> hourlyFromJson(var str) => 
List<HourlyWeather>.from(str.map((x)=>(HourlyWeather.fromJson(x))));

class HourlyWeather {
  final double temperature;
  final String icon;
  HourlyWeather({
    required this.temperature,
    required this.icon,
  });
  

  HourlyWeather copyWith({
    double? temperature,
    String? icon,
  }) {
    return HourlyWeather(
      temperature: temperature ?? this.temperature,
      icon: icon ?? this.icon,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'temperature': temperature,
      'icon': icon,
    };
  }

  factory HourlyWeather.fromJson(Map<String, dynamic> json) {
    return HourlyWeather(
      temperature: json['temp_c'],
      icon: json['condition']['icon'],
    );
  }

  // String toJson() => json.encode(toMap());

  // factory HourlyWeather.fromJson(String source) => HourlyWeather.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'HourlyWeather(temperature: $temperature, icon: $icon)';

  @override
  bool operator ==(covariant HourlyWeather other) {
    if (identical(this, other)) return true;
  
    return 
      other.temperature == temperature &&
      other.icon == icon;
  }

  @override
  int get hashCode => temperature.hashCode ^ icon.hashCode;
}

