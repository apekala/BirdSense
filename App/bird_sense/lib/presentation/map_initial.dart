import 'package:bird_sense/application/device/bloc/device_bloc.dart';
import 'package:bird_sense/application/markers/bloc/markers_bloc.dart';
import 'package:bird_sense/data/model/color.dart';
import 'package:bird_sense/presentation/articles.dart';
import 'package:bird_sense/presentation/bottom_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';

class MapInitialPage extends HookWidget {
  const MapInitialPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var _mapController = MapController();

    var moveState = useState(false);
    var positionState = useState(const LatLng(0, 0));
    var city = useState('');
    var subCity = useState('');

    return BlocBuilder<MarkersBloc, MarkersState>(
      builder: (contextMarker, state) {
        return BlocBuilder<DeviceBloc, DeviceState>(
          builder: (context, state) {
            if (state is DeviceLoaded) {
              return Scaffold(
                backgroundColor: BSColors.backgroundColor,
                body: Stack(children: [
                  FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      initialCenter: LatLng(state.device![0].latitude,
                          state.device![0].longitude),
                      initialZoom: 10.0,
                      onMapEvent: (p0) {
                        if (p0 is MapEventMove) {
                          moveState.value = true;
                        }
                        if (p0 is MapEventMoveEnd) {
                          moveState.value = false;
                        }
                      },
                      onPositionChanged: (position, hasGesture) {
                        positionState.value = position.center!;
                      },
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.example.app',
                        subdomains: const ['a', 'b', 'c'],
                      ),
                      MarkerLayer(markers: [
                        for (int index = 0;
                            index < state.device!.length;
                            index++)
                          Marker(
                            width: 120.0,
                            height: 140.0,
                            point: LatLng(state.device![index].latitude,
                                state.device![index].longitude),
                            child: IconButton(
                              onPressed: () {
                                 contextMarker.read<MarkersBloc>().add(MarkersChange(marker: LatLng(state.device![index].latitude,
                                state.device![index].longitude), devEui: state.device![index].devEUI,));
                              },
                              icon: const Icon(
                                Icons.place,
                                color: Colors.blueAccent,
                                size: 40,
                              ),
                            ),
                          )
                      ])
                    ],
                  ),
                  Align(
                    alignment: const Alignment(0, -0.9),
                    child: Container(
                      margin:
                          const EdgeInsets.only(left: 50, right: 50, top: 10),
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: BSColors.backgroundColor,
                          borderRadius: BorderRadius.circular(30)),
                      child: const Center(
                        child: Text(
                          'Choose device',
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                    ),
                  ),
                ]),
              );
            } else {
              return Scaffold(
                  backgroundColor: BSColors.backgroundColor,
                  body: const Center(
                    child: CircularProgressIndicator(),
                  ));
            }
          },
        );
      },
    );
  }
}
