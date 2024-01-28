// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bird_sense/data/birds/model/articles_model.dart';
import 'package:bird_sense/data/birds/model/birds_model.dart';

class ArticlesEntity {
  final String header;
  final int publishTime;
  final String articleURL;
  final String imageURL;

  ArticlesEntity({
    required this.header,
    required this.publishTime,
    required this.articleURL,
    required this.imageURL,
  });

  static ArticlesEntity fromModel(ArticlesModel model){
    return ArticlesEntity(
      header:model.header, 
      publishTime: model.publishTime,  
      articleURL: model.articleURL,
      imageURL: model.imageURL
      );
  }
}
