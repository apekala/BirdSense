part of 'markers_bloc.dart';

@immutable
sealed class MarkersState {}

final class MarkersInitial extends MarkersState {}

class MarkersLoading extends MarkersState{
  final LatLng? last_markers;

  MarkersLoading({this.last_markers});
}

class MarkersLoaded extends MarkersState{
  final LatLng markers;
  final String devEui;

  MarkersLoaded({required this.markers, required this.devEui});

  
}
