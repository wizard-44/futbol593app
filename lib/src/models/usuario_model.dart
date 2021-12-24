import 'dart:convert';

PerfilUsuario perfilUsuarioFromJson(String str) => PerfilUsuario.fromJson(json.decode(str));

class PerfilUsuario {
    PerfilUsuario({
        this.nombrePu,
        this.iconPu,
        this.descripcionPu,
        this.icon2PreferenciaPu,
        this.nombrePreferenciaPe,
    });

    String ? nombrePu;
    String ? iconPu;
    String ? descripcionPu;
    String ? icon2PreferenciaPu;
    String ? nombrePreferenciaPe;

    factory PerfilUsuario.fromJson(Map<String, dynamic> json) => PerfilUsuario(
        nombrePu: json["Nombre_pu"],
        iconPu: json["icon_pu"],
        descripcionPu: json["descripcion_pu"],
        icon2PreferenciaPu: json["icon2_preferencia_pu"],
        nombrePreferenciaPe: json["nombre_preferencia_pe"],
    );

}
