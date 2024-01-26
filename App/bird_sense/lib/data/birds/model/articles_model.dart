// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
List<ArticlesModel> articlesFromJson(String str) => List<ArticlesModel>.from(json.decode(str).map((x)=>(ArticlesModel.fromJson(x))));
String postToJson(List<ArticlesModel> data) => json.encode(List<dynamic>.from(data.map((x)=>(x.toJson()))));


class ArticlesModel {

  String header;
  int publishTime;
  String articleURL;
  String imageURL;
  ArticlesModel({
    required this.header,
    required this.publishTime,
    required this.articleURL,
    required this.imageURL
  });

  ArticlesModel copyWith({
    String? header,
    int? publishTime,
    String? articleURL,
    String? imageURL,
  }) {
    return ArticlesModel(
      header: header ?? this.header,
      publishTime: publishTime ?? this.publishTime,
      articleURL: articleURL ?? this.articleURL,
      imageURL: imageURL ?? this.imageURL
    );
  }
  factory ArticlesModel.fromJson(Map<String, dynamic> json) {
      return ArticlesModel(
        header: json['header'],
        publishTime: json['publish_time'],
        articleURL: json['article_url'],
        imageURL: json['img_url']
      );
    }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'species': header,
      'confidence': publishTime,
      'time': articleURL,
    };
  }

  

  //String toJson() => json.encode(toMap());

  //factory BirdModel.fromJson(String source) => BirdModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Bird(devEUI: $header, latitude: $publishTime, longitude: $articleURL)';

  @override
  bool operator ==(covariant ArticlesModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.header == header &&
      other.publishTime == articleURL &&
      other.articleURL == articleURL;
  }

  @override
  int get hashCode => header.hashCode ^ publishTime.hashCode ^ articleURL.hashCode;
}
