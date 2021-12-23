import 'dart:convert';

Equipos equiposFromJson(String str) => Equipos.fromJson(json.decode(str));

class Equipos {
    Equipos({
        this.nombreEqui,
        this.iconEqui,
    });

    String ? nombreEqui;
    String ? iconEqui;

    factory Equipos.fromJson(Map<String, dynamic> json) => Equipos(
        nombreEqui: json["Nombre_equi"],
        iconEqui: json["Icon_equi"],
    );

}