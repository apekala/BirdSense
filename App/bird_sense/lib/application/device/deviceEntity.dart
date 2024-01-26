
import 'package:bird_sense/data/birds/model/device_model.dart';

class DeviceEntity{
  final String devEUI;
  final double latitude;
  final double longitude;

  DeviceEntity({required this.devEUI, required this.latitude, required this.longitude});

  static DeviceEntity fromModel(DeviceModel model){
    return DeviceEntity(
      devEUI: model.devEUI, 
      latitude: model.latitude, 
      longitude: model.longitude
      );
  }
}