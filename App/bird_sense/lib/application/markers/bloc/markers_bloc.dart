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
        emit(MarkersLoaded(markers: const LatLng(0, 0), devEui: ''));
        

      
    });
    

   on<MarkersChange>((event, emit) {
      if (state is MarkersLoaded ){
        final LatLng latLngs = event.marker;
        final String devEUI = event.devEui;
        
        

       
        emit(MarkersLoaded(markers: latLngs, devEui: devEUI ));
      }
      else {
        emit(MarkersLoading());
      }
   });

  }
}
