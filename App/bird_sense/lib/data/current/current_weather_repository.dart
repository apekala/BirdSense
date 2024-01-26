

import 'package:bird_sense/data/core/wather_client.dart';
import 'package:bird_sense/data/current/models/current_weather.dart';

class CurrentWeatherRepository {
  final WeatherClient client;

  CurrentWeatherRepository({
    required this.client,
  });

  Future<CurrentWeather?> getWeather(String location) async {
    try {
      final model = await client.getCurrent(location);

      return model.current;
    } catch (e) {
      print('EXCEPTION: $e');
    }
  }
}