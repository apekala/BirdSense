part of 'sorted_birds_bloc.dart';

@immutable
sealed class SortedBirdsEvent {}

class SortedBirdsCount extends SortedBirdsEvent{
  final int after;
  final int before;

  SortedBirdsCount({required this.after, required this.before});

}

class SortedBirdsRefresh extends SortedBirdsEvent{

}
