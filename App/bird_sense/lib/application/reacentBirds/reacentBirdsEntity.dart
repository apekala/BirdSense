import 'package:bird_sense/data/birds/model/birds_model.dart';

class ReacentBirdsEntity{
  final String species;
  final double confidence;
  final int time;

  ReacentBirdsEntity({required this.species, required this.confidence, required this.time});

  static ReacentBirdsEntity fromModel(BirdModel model){
    return ReacentBirdsEntity(
      species:model.species, 
      confidence: model.confidence,  
      time: model.time
      );
  }
}