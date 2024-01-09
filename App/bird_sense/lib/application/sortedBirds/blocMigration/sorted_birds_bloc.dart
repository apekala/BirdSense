import 'package:bird_sense/application/sortedBirds/sortedBirdsEntity.dart';
import 'package:bird_sense/data/birds/sorted_birds_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'sorted_birds_event.dart';
part 'sorted_birds_state.dart';

class SortedMigrationBirdsBloc extends Bloc<SortedMigrationBirdsEvent, SortedMigrationBirdsState> {
  final SortedBirdsRepository repository;
  SortedMigrationBirdsBloc({required this.repository}) : super(SortedMigrationBirdsInitial()) {
    on<SortedMigrationBirdsCount>((event, emit) async{
      final after = event.after;
      final before = event.before;
      // final date = event.date;

      final state = this.state;

      if (state is SortedMigrationBirdsLoaded) {
        emit(SortedMigrationBirdsLoading(lastBirds: state.sortedBirds, 
        // date: state.date
        ));
      } else {
        emit(SortedMigrationBirdsLoading());
      }

      final birds = await repository.getSortedBirds(after, before);
      
      if (birds != null){
        
        final birdsEntity = birds.map((e) =>  SortedBirdsEntity.fromModel(e)).toList();
        emit(SortedMigrationBirdsLoaded(sortedBirds: birdsEntity, 
        // date: date
        ));
      }
      else{
        emit(SortedMigrationBirdsInitial());
      }
      
    });
    on<SortedMigrationBirdsRefresh>((event, emit){
       if (state is SortedMigrationBirdsLoaded){
        final state = this.state as SortedMigrationBirdsLoaded;
        emit(SortedMigrationBirdsLoaded(sortedBirds: state.sortedBirds, 
        // date: state.date
        ));

    }});
  }
}
