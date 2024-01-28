
List<ForecastWeather> forecastFromJson(var str) => 
List<ForecastWeather>.from(str.map((x)=>(ForecastWeather.fromJson(x))));


class ForecastWeather {

  final double maxTemp;
  final double minTemp;
  final int humidity;
  final String conditionIcon;
  
  ForecastWeather({
    required this.maxTemp,
    required this.minTemp,
    required this.humidity,
    required this.conditionIcon,
    
  });



  ForecastWeather copyWith({
    double? maxTemp,
    double? minTemp,
    int? humidity,
    String? conditionIcon,
  }) {
    return ForecastWeather(
      maxTemp: maxTemp ?? this.maxTemp,
      minTemp: minTemp ?? this.minTemp,
      humidity: humidity ?? this.humidity,
      conditionIcon: conditionIcon ?? this.conditionIcon,
     
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'maxtemp_c': maxTemp,
      'mintemp_c': minTemp,
      'avghumidity': humidity,
      // 'conditionIcon': conditionIcon,
    };
  }

  factory ForecastWeather.fromJson(Map<String, dynamic> json) {
    return ForecastWeather(
      maxTemp: json["day"]['maxtemp_c'],
      minTemp: json["day"]['mintemp_c'],
      humidity: json["day"]['avghumidity'],
      conditionIcon: json["day"]['condition']['icon'],
    );
  }

  // String toJson() => json.encode(toMap());

  // factory ForecastWeather.fromJson(String source) => ForecastWeather.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ForcastWeather(maxTemp: $maxTemp, minTemp: $minTemp, humidity: $humidity, conditionIcon: $conditionIcon)';
  }

  @override
  bool operator ==(covariant ForecastWeather other) {
    if (identical(this, other)) return true;
  
    return 
      other.maxTemp == maxTemp &&
      other.minTemp == minTemp &&
      other.humidity == humidity &&
      other.conditionIcon == conditionIcon;
  }

  @override
  int get hashCode {
    return maxTemp.hashCode ^
      minTemp.hashCode ^
      humidity.hashCode ^
      conditionIcon.hashCode;
  }
}
