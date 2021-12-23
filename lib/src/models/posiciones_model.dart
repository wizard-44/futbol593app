import 'dart:convert';

TablaPosiciones tablaPosicionesFromJson(String str) => TablaPosiciones.fromJson(json.decode(str));

class TablaPosiciones {
    TablaPosiciones({
        this.posicionTp,
        this.iconTp,
        this.nombreTp,
        this.pjTp,
        this.pgTp,
        this.peTp,
        this.ppTp,
        this.gfTp,
        this.gcTp,
        this.gdTp,
        this.ptsTp,
    });

    int ? posicionTp;
    String ? iconTp;
    String ? nombreTp;
    int ? pjTp;
    int ? pgTp;
    int ? peTp;
    int ? ppTp;
    int ? gfTp;
    int ? gcTp;
    int ? gdTp;
    int ?ptsTp;

    factory TablaPosiciones.fromJson(Map<String, dynamic> json) => TablaPosiciones(
        posicionTp: json["posicion_tp"],
        iconTp: json["Icon_tp"],
        nombreTp: json["Nombre_tp"],
        pjTp: json["PJ_tp"],
        pgTp: json["PG_tp"],
        peTp: json["PE_tp"],
        ppTp: json["PP_tp"],
        gfTp: json["GF_tp"],
        gcTp: json["GC_tp"],
        gdTp: json["GD_tp"],
        ptsTp: json["Pts_tp"],
    );

}
