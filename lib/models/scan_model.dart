import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

ScanModel scanModelFromJson(String str) => ScanModel.fromJson(json.decode(str));

String scanModelToJson(ScanModel data) => json.encode(data.toJson());

class ScanModel {
  int id = 0;
  String tipo = '';
  String valor;
  ScanModel({required this.valor, this.id = 0}) {
    if (this.valor.contains("http")) {
      this.tipo = 'http';
    } else {
      this.tipo = 'geo';
    }
  }

  LatLng getLatLng() {
    final latLng = this.valor.substring(4).split(',');
    final lat = double.parse(latLng[0]);
    final lng = double.parse(latLng[1]);
    return LatLng(lat, lng);
  }

  factory ScanModel.fromJson(Map<String, dynamic> json) =>
      ScanModel(valor: json["valor"], id: json['id']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
        "valor": valor,
      };
}
