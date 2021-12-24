import 'dart:convert';

Equipos equiposFromJson(String str) => Equipos.fromJson(json.decode(str));

class Equipos {
    Equipos({
        this.nombre,
        this.icono,
        this.pj,
        this.pg,
        this.pe,
        this.pp,
        this.gf,
        this.gc,
        this.gd,
        this.pts,
    });

    String ? nombre;
    String ? icono;
    int ? pj;
    int ? pg;
    int ? pe;
    int ? pp;
    int ? gf;
    int ? gc;
    int ? gd;
    int ? pts;
 
    factory Equipos.fromJson(Map<String, dynamic> json) => Equipos(
        nombre: json["nombre"],
        icono: json["icono"],
        pj: json["PJ"],
        pg: json["PG"],
        pe: json["PE"],
        pp: json["PP"],
        gf: json["GF"],
        gc: json["GC"],
        gd: json["GD"],
        pts: json["Pts"],
    );

}