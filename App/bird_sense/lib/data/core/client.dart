

import 'dart:convert';

import 'package:bird_sense/data/birds/model/birds_model.dart';
import 'package:bird_sense/data/core/base_client.dart';
import 'package:bird_sense/data/core/client_path.dart';

class Client extends BSBaseClient {
  Future<List<BirdModel>?> getBirds(String time)  async{
    final response = await get(ClientPath.birds.getUri(time));//globalControler.getCity().value));
    //var jsonString = jsonDecode(response.body);
    //weatherData = WeatherData(WeatherDataCurrent.fromMap(jsonString));
   //return weatherData!;
  //  if (response.statusCode == 200){
    var json = response.body;
   return birdsFromJson(json);
  //  }
   //return null;
  }

}