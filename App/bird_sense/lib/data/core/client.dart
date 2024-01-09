

import 'dart:convert';

import 'package:bird_sense/data/birds/model/birds_model.dart';
import 'package:bird_sense/data/birds/model/sorted_birds_model.dart';
import 'package:bird_sense/data/core/base_client.dart';
import 'package:bird_sense/data/core/client_path.dart';

class Client extends BSBaseClient {
  Future<List<BirdModel>?> getBirds(int after, int before)  async{
    final response = await get(ClientPath.birds.getUri(after.toString(),before.toString(),'%'));//globalControler.getCity().value));
  if (response.statusCode == 200){
    var json = response.body;
    return birdsFromJson(json);
    }
   return null;
  }

  Future<List<SortedBirdsModel>?> getSortedBirds(int after, int before)  async{
    final response = await get(ClientPath.birdsSort.getUriSorted(after.toString(),before.toString(), '%'));//globalControler.getCity().value));
  if (response.statusCode == 200){
    var json = response.body;
    return sortedBirdsFromJson(json);
    }
   return null;
  }



}