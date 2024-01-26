

import 'package:bird_sense/api/api_key.dart';

enum WeatherClientPath{
  current,
  forecast;

  const WeatherClientPath();

  String get path {
    switch (this) {
      case WeatherClientPath.current:
        return '/v1/current.json';
      case WeatherClientPath.forecast:
        return '/v1/forecast.json';
    }
  }

   Uri get baseUri => Uri.https(
        'api.weatherapi.com',
        '',
        <String, dynamic>{
          'key': tmdbApiKey,
          'aqi': 'no',
        },
      );

  Uri getUri([String? query]) {
    if (query == null) {
      return Uri.https(
        baseUri.authority,
        path,
        baseUri.queryParameters,
      );
    }

    return Uri.https(
      baseUri.authority,
      WeatherClientPath.current.path,
      <String, dynamic>{...baseUri.queryParameters, 'q': query},
    );
  }
  Uri getUriforecast([String? query]) {
    if (query == null) {
      return Uri.http(
        baseUri.authority,
        path,
        baseUri.queryParameters,
      );
    }

    return Uri.http(
      baseUri.authority,
      WeatherClientPath.forecast.path,
      <String, dynamic>{...baseUri.queryParameters, 'q': query, 'days':'10'},
    );
  }
}