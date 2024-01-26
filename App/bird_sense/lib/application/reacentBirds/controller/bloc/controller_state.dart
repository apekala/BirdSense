part of 'controller_bloc.dart';

@immutable
sealed class ControllerState {}

final class ControllerInitial extends ControllerState {}
final class ControllerLoading extends ControllerState {}

final class ControllerLoaded extends ControllerState {
  final bool controlerState;

  ControllerLoaded({required this.controlerState});
}
