part of 'reacent_birds_bloc.dart';

@immutable
sealed class ReacentBirdsEvent {} 

class ReacentBirdsCount extends ReacentBirdsEvent{
  final int after;
  final int before;
  final String devEUI;

  ReacentBirdsCount({required this.after, required this.before, required this.devEUI});

}