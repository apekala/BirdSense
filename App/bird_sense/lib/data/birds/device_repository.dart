


import 'package:bird_sense/data/birds/model/device_model.dart';
import 'package:bird_sense/data/core/client.dart';

class DeviceRepository{
  final Client client;

  DeviceRepository({required this.client});

  Future<List<DeviceModel>?> getDevice() async{
    try{
      final model = await client.getDeviceEUI();
     
      return model;
    } catch (e){
      print('EXCEPTION: $e');
    }
    return null;
  }
}