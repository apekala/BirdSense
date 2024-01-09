part of 'markers_bloc.dart';

@immutable
sealed class MarkersEvent {}

class MarkersCounter extends MarkersEvent{

}

class MarkersAdd extends MarkersEvent{
  final LatLng marker;

  MarkersAdd({required this.marker});

}

class MarkersRemove extends MarkersEvent{
  final LatLng marker;

  MarkersRemove({required this.marker});

}

class MarkersChange extends MarkersEvent{
  final LatLng marker;
  final int index;

  MarkersChange({required this.marker, required this.index});

}

class MarkersRefresh extends MarkersEvent{


}
