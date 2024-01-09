import 'package:bird_sense/application/sortedBirds/sortedBirdsEntity.dart';
import 'package:bird_sense/data/birds/sorted_birds_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'sorted_birds_event.dart';
part 'sorted_birds_state.dart';

class SortedBirdsBloc extends Bloc<SortedBirdsEvent, SortedBirdsState> {
  final SortedBirdsRepository repository;
  SortedBirdsBloc({required this.repository}) : super(SortedBirdsInitial()) {
    on<SortedBirdsCount>((event, emit) async{
      final after = event.after;
      final before = event.before;

      final state = this.state;

      if (state is SortedBirdsLoaded) {
        emit(SortedBirdsLoading(lastBirds: state.sortedBirds));
      } else {
        emit(SortedBirdsLoading());
      }
      
      final birds = await repository.getSortedBirds(after, before);
      
      if (birds != null){
        
        final birdsEntity = birds.map((e) =>  SortedBirdsEntity.fromModel(e)).toList();
        emit(SortedBirdsLoaded(sortedBirds: birdsEntity));
      }
      else{
        emit(SortedBirdsInitial());
      }
      
    });
    on<SortedBirdsRefresh>((event, emit){
       if (state is SortedBirdsLoaded){
        final state = this.state as SortedBirdsLoaded;
        emit(SortedBirdsLoaded(sortedBirds: state.sortedBirds
        ));

    }});
  }
}
