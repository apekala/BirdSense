import 'package:bird_sense/data/markers/models/marker_model.dart';
import 'package:bloc/bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:meta/meta.dart';

part 'markers_event.dart';
part 'markers_state.dart';

class MarkersBloc extends Bloc<MarkersEvent, MarkersState> {
  MarkersBloc() : super(MarkersInitial()) {
    on<MarkersCounter>((event, emit) async{
       await Future<void>.delayed(const Duration(seconds: 1));
        emit(MarkersLoaded(markers: const <LatLng>[]));
      
      
    });
    on<MarkersAdd>((event, emit) {
      if (state is MarkersLoaded){
        final state = this.state as MarkersLoaded;
        emit(MarkersLoaded(markers: List.from(state.markers)..add(event.marker)
        ));
      }
      else {
        emit(MarkersLoading());
      }


    });
     on<MarkersRefresh>((event, emit) async{
        if (state is MarkersLoaded){
        final state = this.state as MarkersLoaded;
        emit(MarkersLoaded(markers: List.from(state.markers)
        ));
      }

  });

   on<MarkersRemove>((event, emit) {
      if (state is MarkersLoaded){
        final state = this.state as MarkersLoaded;
        emit(MarkersLoaded(markers: List.from(state.markers)..remove(event.marker)
        ));
      }
      else {
        emit(MarkersLoading());
      }
   });

   on<MarkersChange>((event, emit) {
      if (state is MarkersLoaded){
        final state = this.state as MarkersLoaded;
        final List<LatLng> latLngs = [];
        latLngs.add(event.marker);

        emit(MarkersLoaded(markers: List.from(state.markers)..replaceRange(event.index, event.index+1, latLngs)
        ));
      }
      else {
        emit(MarkersLoading());
      }
   });

  }
}
