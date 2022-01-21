// To parse this JSON data, do
//
//     final equipo = equipoFromJson(jsonString);

import 'dart:convert';

Equipo equipoFromJson(String str) => Equipo.fromJson(json.decode(str));

String equipoToJson(Equipo data) => json.encode(data.toJson());

class Equipo {
    Equipo({
        this.idEquipo,
        this.nombre,
        this.urlfoto,
        this.historia,
        this.partidosGanados,
        this.partidosEmpatados,
        this.partidosPerdidos,
        this.golesFavor,
        this.golesEncontra,
    });

    String ?idEquipo;
    String ?nombre;
    String ?urlfoto;
    String ?historia;
    int ?partidosGanados;
    int ?partidosEmpatados;
    int ?partidosPerdidos;
    int ?golesFavor;
    int ?golesEncontra;

    factory Equipo.fromJson(Map<String, dynamic> json) => Equipo(
        idEquipo: json["idEquipo"],
        nombre: json["nombre"],
        urlfoto: json["urlfoto"],
        historia: json["historia"],
        partidosGanados: json["partidosGanados"],
        partidosEmpatados: json["partidosEmpatados"],
        partidosPerdidos: json["partidosPerdidos"],
        golesFavor: json["golesFavor"],
        golesEncontra: json["golesEncontra"],
    );

    Map<String, dynamic> toJson() => {
        "idEquipo": idEquipo,
        "nombre": nombre,
        "urlfoto": urlfoto,
        "historia": historia,
        "partidosGanados": partidosGanados,
        "partidosEmpatados": partidosEmpatados,
        "partidosPerdidos": partidosPerdidos,
        "golesFavor": golesFavor,
        "golesEncontra": golesEncontra,
    };
}
