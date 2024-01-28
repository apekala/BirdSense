part of 'reacent_birds_bloc.dart';

@immutable
sealed class ReacentBirdsState {}

final class ReacentBirdsInitial extends ReacentBirdsState {}

class ReacentBirdsLoading extends ReacentBirdsState{
  final List<ReacentBirdsEntity>? lastBirds;

  ReacentBirdsLoading({this.lastBirds});
}

class ReacentBirdsLoaded extends ReacentBirdsState{
  final List<ReacentBirdsEntity> reacentBirds;

  ReacentBirdsLoaded({required this.reacentBirds});
}

