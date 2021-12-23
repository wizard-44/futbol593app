import 'dart:convert';

Calendario calendarioFromJson(String str) => Calendario.fromJson(json.decode(str));

class Calendario {
    Calendario({
        this.tituloCal,
        this.subtituloCal,
        this.fechaCal,
        this.horaCal,
        this.iconCal1,
        this.iconCal2,
    });

    String ? tituloCal;
    String ? subtituloCal;
    String ? fechaCal;
    String ? horaCal;
    String ? iconCal1;
    String ? iconCal2;

    factory Calendario.fromJson(Map<String, dynamic> json) => Calendario(
        tituloCal: json["titulo_cal"],
        subtituloCal: json["subtitulo_cal"],
        fechaCal: json["fecha_cal"],
        horaCal: json["hora_cal"],
        iconCal1: json["icon_cal_1"],
        iconCal2: json["icon_cal_2"],
    );

}
