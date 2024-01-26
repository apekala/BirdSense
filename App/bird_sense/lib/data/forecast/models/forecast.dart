// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import "dart:convert";

// import "package:mobile/data/current/models/location.dart";
// import "package:mobile/data/forecast/models/forecastWeather.dart";
// List<Forecast> birdsFromJson(String str) => List<Forecast>.from(json.decode(str).map((x)=>(Forecast.fromJson(x))));
// class Forecast {
//   final Location location;
//   final ForecastWeather forecast;
//   Forecast({
//     required this.location,
//     required this.forecast,
//   });


//   Forecast copyWith({
//     Location? location,
//     ForecastWeather? forecast,
//   }) {
//     return Forecast(
//       location: location ?? this.location,
//       forecast: forecast ?? this.forecast,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'location': location.toMap(),
//       'forecast': forecast.toMap(),
//     };
//   }

//   factory Forecast.fromMap(Map<String, dynamic> map) {
//     return Forecast(
//       location: Location.fromMap(map['location']),
//       forecast: ForecastWeather.fromMap(map['forecast']['forecastday']),
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Forecast.fromJson(String source) => Forecast.fromMap(json.decode(source) as Map<String, dynamic>);

//   @override
//   String toString() => 'Forecast(location: $location, forecast: $forecast)';

//   @override
//   bool operator ==(covariant Forecast other) {
//     if (identical(this, other)) return true;
  
//     return 
//       other.location == location &&
//       other.forecast == forecast;
//   }

//   @override
//   int get hashCode => location.hashCode ^ forecast.hashCode;
// }
