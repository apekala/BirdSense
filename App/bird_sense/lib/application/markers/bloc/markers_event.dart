part of 'markers_bloc.dart';

@immutable
sealed class MarkersEvent {}

class MarkersCounter extends MarkersEvent{
  // final LatLng marker;

  // MarkersCounter({   // required this.marker
    // });

}



class MarkersChange extends MarkersEvent{
  final LatLng marker;
  final String devEui;

  MarkersChange({required this.marker, required this.devEui});

}

