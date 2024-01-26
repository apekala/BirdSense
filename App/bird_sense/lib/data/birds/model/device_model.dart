// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
List<DeviceModel> deviceFromJson(String str) => List<DeviceModel>.from(json.decode(str).map((x)=>(DeviceModel.fromJson(x))));
String postToJson(List<DeviceModel> data) => json.encode(List<dynamic>.from(data.map((x)=>(x.toJson()))));


class DeviceModel {

  String devEUI;
  double latitude;
  double longitude;
  DeviceModel({
    required this.devEUI,
    required this.latitude,
    required this.longitude,
  });

  DeviceModel copyWith({
    String? devEUI,
    double? latitude,
    double? longitude,
  }) {
    return DeviceModel(
      devEUI: devEUI ?? this.devEUI,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
  factory DeviceModel.fromJson(Map<String, dynamic> json) {
      return DeviceModel(
        devEUI: json['dev_eui'],
        latitude: json['latitude'],
        longitude: json['longitude'],
      );
    }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'species': devEUI,
      'confidence': latitude,
      'time': longitude,
    };
  }

  

  //String toJson() => json.encode(toMap());

  //factory BirdModel.fromJson(String source) => BirdModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Bird(devEUI: $devEUI, latitude: $latitude, longitude: $longitude)';

  @override
  bool operator ==(covariant DeviceModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.devEUI == devEUI &&
      other.latitude == latitude &&
      other.longitude == longitude;
  }

  @override
  int get hashCode => devEUI.hashCode ^ latitude.hashCode ^ longitude.hashCode;
}
