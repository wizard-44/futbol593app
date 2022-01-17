import 'dart:convert';

Partido calendarioFromJson(String str) => Partido.fromJson(json.decode(str));

class Partido {
    Partido({
        this.equipolocal,
        this.equipovisitante,
        this.estadio,
        this.fecha,
        this.hora,
        this.icon1,
        this.icon2,
    });

    String ? equipolocal;
    String ? equipovisitante;
    String ? estadio;
    String ? fecha;
    String ? hora;
    String ? icon1;
    String ? icon2;

    factory Partido.fromJson(Map<String, dynamic> json) => Partido(
        equipolocal: json["equipo_local"],
        equipovisitante: json["equipo_visitante"],
        estadio: json["estadio"],
        fecha: json["fecha"],
        hora: json["hora"],
        icon1: json["icon1"],
        icon2: json["icon2"],
    );

}
