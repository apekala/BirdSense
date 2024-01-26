// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bird_sense/application/reacentBirds/reacentBirdsEntity.dart';
import 'package:bird_sense/data/birds/birds_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'reacent_birds_event.dart';
part 'reacent_birds_state.dart';

class ReacentBirdsBloc extends Bloc<ReacentBirdsEvent, ReacentBirdsState> {
  final ReacentBirdsRepository repository;
  ReacentBirdsBloc({
    required this.repository,
  }) : super(ReacentBirdsInitial()) {
    on<ReacentBirdsCount>((event, emit) async{
      final after = event.after;
      final before = event.before;
      final devEUI = event.devEUI;

      final state = this.state;

      if (state is ReacentBirdsLoaded) {
        emit(ReacentBirdsLoading(lastBirds: state.reacentBirds));
      } else {
        emit(ReacentBirdsLoading());
      }

      final birds = await repository.getBirds(after, before, devEUI);
      
      if (birds != null){
        
        final birdsEntity = birds.map((e) =>  ReacentBirdsEntity.fromModel(e)).toList();
        emit(ReacentBirdsLoaded(reacentBirds: birdsEntity));
      }
      else{
        emit(ReacentBirdsInitial());
      }

    });
  }
}
