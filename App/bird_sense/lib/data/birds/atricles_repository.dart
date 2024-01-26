


import 'package:bird_sense/data/birds/model/articles_model.dart';
import 'package:bird_sense/data/birds/model/device_model.dart';
import 'package:bird_sense/data/core/client.dart';

class ArticlesRepository{
  final Client client;

  ArticlesRepository({required this.client});

  Future<List<ArticlesModel>?> getArticles() async{
    try{
      final model = await client.getArticles();
     
      return model;
    } catch (e){
      print('EXCEPTION: $e');
    }
    return null;
  }
}