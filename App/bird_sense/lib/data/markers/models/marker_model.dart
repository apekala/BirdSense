import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:latlong2/latlong.dart';

class Marker{
  final int id;
  final LatLng latLng;

  Marker({required this.id, required this.latLng});
  
}