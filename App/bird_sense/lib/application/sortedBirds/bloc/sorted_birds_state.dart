part of 'sorted_birds_bloc.dart';

@immutable
sealed class SortedBirdsState {}

final class SortedBirdsInitial extends SortedBirdsState {}

class SortedBirdsLoading extends SortedBirdsState{
  final List<SortedBirdsEntity>? lastBirds;

  SortedBirdsLoading({this.lastBirds});
}

class SortedBirdsLoaded extends SortedBirdsState{
  final List<SortedBirdsEntity> sortedBirds;

  SortedBirdsLoaded({required this.sortedBirds});
}
