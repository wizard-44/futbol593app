import 'dart:convert';

PerfilEquipo perfilEquipoFromJson(String str) => PerfilEquipo.fromJson(json.decode(str));

class PerfilEquipo {
    PerfilEquipo({
        this.tituloPe,
        this.iconPe,
        this.descripcionPe,
        this.nombreJugadorPe,
        this.iconJugadorPe,
    });

    String ? tituloPe;
    String ? iconPe;
    String ? descripcionPe;
    String ? nombreJugadorPe;
    String ? iconJugadorPe;

    factory PerfilEquipo.fromJson(Map<String, dynamic> json) => PerfilEquipo(
        tituloPe: json["titulo_pe"],
        iconPe: json["icon_pe"],
        descripcionPe: json["descripcion_pe"],
        nombreJugadorPe: json["nombre_jugador_pe"],
        iconJugadorPe: json["icon_jugador_pe"],
    );

}
