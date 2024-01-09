part of 'reacent_birds_bloc.dart';

@immutable
sealed class ReacentBirdsEvent {} 

class ReacentBirdsCount extends ReacentBirdsEvent{
  final int after;
  final int before;

  ReacentBirdsCount({required this.after, required this.before});

}