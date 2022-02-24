// To parse this JSON data, do
//
//     final estadio = estadioFromJson(jsonString);

import 'dart:convert';

Estadio estadioFromJson(String str) => Estadio.fromJson(json.decode(str));

String estadioToJson(Estadio data) => json.encode(data.toJson());

class Estadio {
  Estadio({
      this.nombre,
      this.lat,
      this.lng,
  });

  String? nombre;
  double? lat;
  double? lng;

  factory Estadio.fromJson(Map<String, dynamic> json) => Estadio(
      nombre: json["nombre"],
      lat: json["lat"].toDouble(),
      lng: json["lng"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
      "nombre": nombre,
      "lat": lat,
      "lng": lng,
  };
}
