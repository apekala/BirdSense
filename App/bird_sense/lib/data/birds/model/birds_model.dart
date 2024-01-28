// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
List<BirdModel> birdsFromJson(String str) => List<BirdModel>.from(json.decode(str).map((x)=>(BirdModel.fromJson(x))));
String postToJson(List<BirdModel> data) => json.encode(List<dynamic>.from(data.map((x)=>(x.toJson()))));


class BirdModel {

  String species;
  double confidence;
  int time;
  BirdModel({
    required this.species,
    required this.confidence,
    required this.time,
  });

  BirdModel copyWith({
    String? species,
    double? confidence,
    int? time,
  }) {
    return BirdModel(
      species: species ?? this.species,
      confidence: confidence ?? this.confidence,
      time: time ?? this.time,
    );
  }
  factory BirdModel.fromJson(Map<String, dynamic> json) {
      return BirdModel(
        species: json['species'],
        confidence: json['confidence'],
        time: json['end_time'],
      );
    }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'species': species,
      'confidence': confidence,
      'time': time,
    };
  }

  

  //String toJson() => json.encode(toMap());

  //factory BirdModel.fromJson(String source) => BirdModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Bird(species: $species, confidence: $confidence, time: $time)';

  @override
  bool operator ==(covariant BirdModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.species == species &&
      other.confidence == confidence &&
      other.time == time;
  }

  @override
  int get hashCode => species.hashCode ^ confidence.hashCode ^ time.hashCode;
}
