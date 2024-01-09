// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
List<SortedBirdsModel> sortedBirdsFromJson(String str) => List<SortedBirdsModel>.from(json.decode(str).map((x)=>(SortedBirdsModel.fromJson(x))));
String postToJson(List<SortedBirdsModel> data) => json.encode(List<dynamic>.from(data.map((x)=>(x.toJson()))));


class SortedBirdsModel {
  final String species;
  final int count;
  final int duration;
  SortedBirdsModel({
    required this.species,
    required this.count,
    required this.duration,
  });

  SortedBirdsModel copyWith({
    String? species,
    int? count,
    int? duration,
  }) {
    return SortedBirdsModel(
      species: species ?? this.species,
      count: count ?? this.count,
      duration: duration ?? this.duration,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'species': species,
      'count': count,
      'duration': duration,
    };
  }

  factory SortedBirdsModel.fromJson(Map<String, dynamic> json) {
    return SortedBirdsModel(
      species: json['species'],
      count: json['count'],
      duration: json['duration'],
    );
  }

  // String toJson() => json.encode(toMap());

  // factory SortedBirdsModel.fromJson(String source) => SortedBirdsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SortedBirdsModel(species: $species, count: $count, duration: $duration)';

  @override
  bool operator ==(covariant SortedBirdsModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.species == species &&
      other.count == count &&
      other.duration == duration;
  }

  @override
  int get hashCode => species.hashCode ^ count.hashCode ^ duration.hashCode;
}
