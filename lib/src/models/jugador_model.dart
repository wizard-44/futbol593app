// To parse this JSON data, do
//
//     final jugador = jugadorFromJson(jsonString);

import 'dart:convert';

Jugador jugadorFromJson(String str) => Jugador.fromJson(json.decode(str));

String jugadorToJson(Jugador data) => json.encode(data.toJson());

class Jugador {
    Jugador({
        this.idJugador,
        this.nombre,
        this.urlfoto,
        this.edad,
        this.nacionalidad,
        this.posicion,
        this.numgoles,
        this.idEquipo,
    });

    String ?idJugador;
    String ?nombre;
    String ?urlfoto;
    int ?edad;
    String ?nacionalidad;
    String ?posicion;
    int ?numgoles;
    String ?idEquipo;

    factory Jugador.fromJson(Map<String, dynamic> json) => Jugador(
        idJugador: json["idJugador"],
        nombre: json["nombre"],
        urlfoto: json["urlfoto"],
        edad: json["edad"],
        nacionalidad: json["nacionalidad"],
        posicion: json["posicion"],
        numgoles: json["numgoles"],
        idEquipo: json["idEquipo"],
    );

    factory Jugador.created(String id) => Jugador(idEquipo: id);

    Map<String, dynamic> toJson() => {
        "idJugador": idJugador,
        "nombre": nombre,
        "urlfoto": urlfoto,
        "edad": edad,
        "nacionalidad": nacionalidad,
        "posicion": posicion,
        "numgoles": numgoles,
        "idEquipo": idEquipo,
    };
}
