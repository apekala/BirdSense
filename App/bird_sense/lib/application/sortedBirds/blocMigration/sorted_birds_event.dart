part of 'sorted_birds_bloc.dart';

@immutable
sealed class SortedMigrationBirdsEvent {}

class SortedMigrationBirdsCount extends SortedMigrationBirdsEvent{
  final int after;
  final int before;
  final String devEUI;
  // final DateTime date;

  SortedMigrationBirdsCount({required this.after, required this.before, required this.devEUI
  
  // required this.date
  });

}

class SortedMigrationBirdsRefresh extends SortedMigrationBirdsEvent{

}
