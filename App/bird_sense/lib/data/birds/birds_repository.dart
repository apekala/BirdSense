

import 'package:bird_sense/data/birds/model/birds_model.dart';
import 'package:bird_sense/data/core/client.dart';

class ReacentBirdsRepository{
  final Client client;

  ReacentBirdsRepository({required this.client});

  Future<List<BirdModel>?> getBirds(int after, int before) async{
    try{
      final model = await client.getBirds(after,before);
     
      return model;
    } catch (e){
      print('EXCEPTION: $e');
    }
    return null;
  }
}