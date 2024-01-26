part of 'controller_bloc.dart';

@immutable
sealed class ControllerEvent {}
final class ControllerInitialEvent extends ControllerEvent{
  //  final bool controllerAddState;

  // ContriolerInitialEvent({required this.controllerAddState});
}

final class ControllerAddEvent extends ControllerEvent{
  final bool controllerAddState;

  ControllerAddEvent({required this.controllerAddState});
}
