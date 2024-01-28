
import 'package:bird_sense/data/birds/model/sorted_birds_model.dart';

class SortedBirdsEntity {
  final String species;
  final int count;
  final int duration;

  SortedBirdsEntity({required this.species, required this.count, required this.duration});

  static SortedBirdsEntity fromModel(SortedBirdsModel model){
    return SortedBirdsEntity(
      species: model.species,
      count: model.count,
      duration: model.duration,

      );
  }

}