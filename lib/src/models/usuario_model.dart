import 'dart:convert';

Usuario perfilUsuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

class Usuario {
    Usuario({
        this.nombre,
        this.icon,
        this.descripcion,
        this.icon2Preferencia,
        this.nombrePreferencia,
    });

    String ? nombre;
    String ? icon;
    String ? descripcion;
    String ? icon2Preferencia;
    String ? nombrePreferencia;

    factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        nombre: json["Nombre_pu"],
        icon: json["icon_pu"],
        descripcion: json["descripcion_pu"],
        icon2Preferencia: json["icon2_preferencia_pu"],
        nombrePreferencia: json["nombre_preferencia_pe"],
    );

}
