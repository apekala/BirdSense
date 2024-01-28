import 'package:bird_sense/application/device/bloc/device_bloc.dart';
import 'package:bird_sense/application/markers/bloc/markers_bloc.dart';
import 'package:bird_sense/data/model/color.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';

class MapPage extends HookWidget {
  const MapPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var _mapController = MapController();

    var moveState = useState(false);
    var positionState = useState(const LatLng(0, 0));
    var city = useState('');
    var subCity = useState('');
    Future<List<Placemark>> placemarkFromCoordinates(
      double latitude,
      double longitude, {
      String? localeIdentifier,
    }) =>
        GeocodingPlatform.instance.placemarkFromCoordinates(
          latitude,
          longitude,
          localeIdentifier: localeIdentifier,
        );

    getAdress(latitude, longitude) async {
      List<Placemark> placemark =
          await placemarkFromCoordinates(latitude, longitude);
      Placemark place = placemark[0];
      city.value = place.locality!;
      subCity.value = place.subLocality!;
    }


    return BlocBuilder<DeviceBloc, DeviceState>(
      builder: (context, state) {
        

        if (state is DeviceLoaded) {
          final devices = state;
          return BlocBuilder<MarkersBloc, MarkersState>(
            builder: (contextMarker, state) {
              
              
              if(state is MarkersLoaded){
                
                final markerChoosed = state.markers;
                getAdress(markerChoosed.latitude, markerChoosed.longitude);
                
                return Scaffold(
                

                body: Stack(children: [
                  FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      initialCenter: 
                      // LatLng(52.21885, 21.01077),
                          markerChoosed,
                      initialZoom: 11.0,
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
                            index < devices.device!.length;
                            index++)
                          Marker(
                            width: 120.0,
                            height: 140.0,
                            point: LatLng(devices.device![index].latitude,
                                devices.device![index].longitude),
                            child: IconButton(
                              onPressed: () {
                              contextMarker.read<MarkersBloc>().add(MarkersChange(marker: LatLng(devices.device![index].latitude,
                                devices.device![index].longitude), devEui: devices.device![index].devEUI,));

                              },
                              icon: Icon(
                                Icons.place,
                                color: devices.device![index].latitude == markerChoosed.latitude && devices.device![index].longitude == markerChoosed.longitude ? Colors.purple: Colors.blueAccent,
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
                          const EdgeInsets.only(left: 20, right: 20, top: 10),
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 15, right: 5),
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: BSColors.backgroundColor,
                          borderRadius: BorderRadius.circular(30)),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            size: 25,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            '${city.value}, ${subCity.value}',
                            style: const TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
              );
              }else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
