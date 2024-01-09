import 'package:bird_sense/data/birds/model/birds_model.dart';
import 'package:bird_sense/data/birds/model/sorted_birds_model.dart';
import 'package:bird_sense/data/core/client.dart';

class SortedBirdsRepository{
  final Client client;

  SortedBirdsRepository({required this.client});

  Future<List<SortedBirdsModel>?> getSortedBirds(int after, int before) async{
    try{
      final model = await client.getSortedBirds(after,before);
     
      return model;
    } catch (e){
      print('EXCEPTION: $e');
    }
    return null;
  }
}