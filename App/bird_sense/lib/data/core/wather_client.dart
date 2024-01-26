import 'dart:convert';

import 'package:bird_sense/data/core/base_client.dart';
import 'package:bird_sense/data/core/base_client_weather.dart';
import 'package:bird_sense/data/core/wather_client_path.dart';
import 'package:bird_sense/data/current/models/current.dart';
import 'package:bird_sense/data/forecast/models/forecastWeather.dart';
import 'package:bird_sense/data/forecast/models/hourly_weather.dart';


class WeatherClient extends BSBaseClient {
  Future<Current> getCurrent(String location)  async{
    print(WeatherClientPath.current.getUri(location));
    final response = await get(WeatherClientPath.current.getUri(location));
    print(response.statusCode);
    //var jsonString = jsonDecode(response.body);
    //weatherData = WeatherData(WeatherDataCurrent.fromMap(jsonString));
   //return weatherData!;
   return Current.fromJson(response.body);
  }

  Future<List<ForecastWeather>> getForecast(String location) async {
    final response = await get(WeatherClientPath.forecast.getUriforecast(location));
    var jsonResponse = json.decode(response.body);
      var data = jsonResponse['forecast']['forecastday'];
      


    
    return forecastFromJson(data);
  }

  Future<List<HourlyWeather>> getHourly(String location) async {
    final response = await get(WeatherClientPath.forecast.getUriforecast(location));
    var jsonResponse = json.decode(response.body);
      var data = jsonResponse['forecast']['forecastday'][0]['hour'];
      


    return hourlyFromJson(data);
  }
}

