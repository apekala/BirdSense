part of 'markers_bloc.dart';

@immutable
sealed class MarkersState {}

final class MarkersInitial extends MarkersState {}

class MarkersLoading extends MarkersState{
  final List<LatLng>? last_markers;

  MarkersLoading({this.last_markers});
}

class MarkersLoaded extends MarkersState{
  final List<LatLng> markers;

  MarkersLoaded({required this.markers});

  
}
