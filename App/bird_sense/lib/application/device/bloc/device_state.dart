part of 'device_bloc.dart';

@immutable
sealed class DeviceState {}

final class DeviceInitial extends DeviceState {}

class DeviceLoading extends DeviceState{
  final List<DeviceEntity>? lastDevice;

  DeviceLoading({this.lastDevice}); 
}

class DeviceLoaded extends DeviceState{
  final List<DeviceEntity>? device;

  DeviceLoaded({required this.device});

}
