part of 'sorted_birds_bloc.dart';

@immutable
sealed class SortedMigrationBirdsState {}

final class SortedMigrationBirdsInitial extends SortedMigrationBirdsState {}

class SortedMigrationBirdsLoading extends SortedMigrationBirdsState{
  final List<SortedBirdsEntity>? lastBirds;
  final DateTime? date;

  SortedMigrationBirdsLoading({this.lastBirds, this.date});
}

class SortedMigrationBirdsLoaded extends SortedMigrationBirdsState{
  final List<SortedBirdsEntity> sortedBirds;
  // final DateTime? date;

  SortedMigrationBirdsLoaded({required this.sortedBirds, 
  // required this.date
  });
}
