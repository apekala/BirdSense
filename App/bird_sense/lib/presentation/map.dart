import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends HookWidget{
   const MapPage({
    super.key, 
    });
  
  @override
    Widget build(BuildContext context) {
      final mapController = MapController();
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Map")),
      ),
      body: FlutterMap(
        mapController: mapController,
        options:
            const MapOptions(initialCenter: LatLng(52.21769884997918, 21.01443708154715), initialZoom: 13.0,
            ),
        children: [
          TileLayer(
             minZoom: 1,
            maxZoom: 18,
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.app',
              subdomains: const ['a', 'b', 'c'],
              ),
          const MarkerLayer(markers: [
            Marker(
                width: 30.0,
                height: 30.0,
                point: LatLng(52.21769884997918, 21.01443708154715),
                child: Icon(
                  Icons.place,
                  color: Colors.blueAccent,
                  size: 50,
                )
                    )
          
          ]
          )
        ],
      ),
    );
  }

}