import 'dart:convert';

Goleadores goleadoresFromJson(String str) => Goleadores.fromJson(json.decode(str));

class Goleadores {
    Goleadores({
        this.nombreGol,
        this.iconGol,
        this.numeroGol,
    });

    String ? nombreGol;
    String ? iconGol;
    int ? numeroGol;

    factory Goleadores.fromJson(Map<String, dynamic> json) => Goleadores(
        nombreGol: json["Nombre_gol"],
        iconGol: json["Icon_gol"],
        numeroGol: json["numero_gol"],
    );

}