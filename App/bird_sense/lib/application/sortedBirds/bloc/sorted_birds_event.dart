part of 'sorted_birds_bloc.dart';

@immutable
sealed class SortedBirdsEvent {}

class SortedBirdsCount extends SortedBirdsEvent{
  final int after;
  final int before;
  final String devEUI;

  SortedBirdsCount({required this.after, required this.before, required this.devEUI});

}

class SortedBirdsRefresh extends SortedBirdsEvent{

}
