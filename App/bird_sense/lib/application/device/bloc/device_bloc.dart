import 'package:bird_sense/application/device/deviceEntity.dart';
import 'package:bird_sense/data/birds/device_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'device_event.dart';
part 'device_state.dart';

class DeviceBloc extends Bloc<DeviceEvent, DeviceState> {
  final DeviceRepository repository;
  DeviceBloc({required this.repository}) : super(DeviceInitial()) {
    on<DeviceCount>((event, emit) async{
      final state = this.state;
      if(state is DeviceLoaded){
        emit(DeviceLoading(lastDevice: state.device));
      }
      else{
        emit(DeviceLoading());

      }

      final devices = await repository.getDevice();
      if(devices != null){
        final deviceEntity = devices.map((e) => DeviceEntity.fromModel(e)).toList();
        emit(DeviceLoaded(device: deviceEntity));
      }
      else{
        emit(DeviceInitial());
      }
    });
  }
}
