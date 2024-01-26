

import 'dart:convert';

import 'package:bird_sense/data/birds/model/articles_model.dart';
import 'package:bird_sense/data/birds/model/birds_model.dart';
import 'package:bird_sense/data/birds/model/device_model.dart';
import 'package:bird_sense/data/birds/model/sorted_birds_model.dart';
import 'package:bird_sense/data/core/base_client.dart';
import 'package:bird_sense/data/core/client_path.dart';

class Client extends BSBaseClient {
  Future<List<BirdModel>?> getBirds(int after, int before, String devEUI)  async{
    final response = await get(ClientPath.birds.getUri(after.toString(),before.toString(), devEUI));
  if (response.statusCode == 200){
    var json = response.body;
    return birdsFromJson(json);
    }
   return null;
  }

  Future<List<SortedBirdsModel>?> getSortedBirds(int after, int before, String devEUI )  async{
    final response = await get(ClientPath.birdsSort.getUriSorted(after.toString(),before.toString(), devEUI));//globalControler.getCity().value));
  if (response.statusCode == 200){
    var json = response.body;
    return sortedBirdsFromJson(json);
    }
   return null;
  }

   Future<List<DeviceModel>?> getDeviceEUI()  async{
    final response = await get(ClientPath.deviceEUI.getUriDevice());//globalControler.getCity().value));
  if (response.statusCode == 200){
    var json = response.body;
    return deviceFromJson(json);
    }
   return null;
  }

  Future<List<ArticlesModel>?> getArticles()  async{
    print(ClientPath.articles.getUriDevice());
      final response = await get(ClientPath.articles.getUriArticles());//globalControler.getCity().value));
    if (response.statusCode == 200){
      var json = response.body;
      return articlesFromJson(json);
      }
    return null;
    }


}