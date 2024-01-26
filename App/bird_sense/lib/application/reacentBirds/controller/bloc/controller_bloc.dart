import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'controller_event.dart';
part 'controller_state.dart';

class ControllerBloc extends Bloc<ControllerEvent, ControllerState> {
  ControllerBloc() : super(ControllerInitial()) {
    on<ControllerInitialEvent>((event, emit) async{
     await Future<void>.delayed(const Duration(seconds: 1));
        emit(ControllerLoaded(controlerState: false));
     
    });

    on<ControllerAddEvent>((event, emit) {
        emit(ControllerLoaded(controlerState: event.controllerAddState));
     
    });
  }
}
