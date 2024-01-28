

import 'package:bird_sense/data/core/wather_client.dart';
import 'package:bird_sense/data/forecast/models/forecastWeather.dart';

class ForecastWeatherRepository {
  final WeatherClient client;

  ForecastWeatherRepository({
    required this.client,
  });

  Future<List<ForecastWeather>?> getWeather(String location) async {
    try {
      final model = await client.getForecast(location);

      return model;
    } catch (e) {
      print('EXCEPTION: $e');
    }
    return null;
  }
}