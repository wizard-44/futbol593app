// To parse this JSON data, do
//
//     final usuario = usuarioFromJson(jsonString);

import 'dart:convert';

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
  Usuario({this.displayName, this.email, this.password, this.role,this.foto,this.fechaNacimiento});

  String? displayName;
  String? email;
  String? password;
  String? role;
  String? foto;
  String? fechaNacimiento;

  Map<String, dynamic> toJson() => {
    "displayName": displayName,
    "email": email,
    "password": password,
    "role": role,
    "foto": foto,
    "fechaNacimiento": fechaNacimiento,
  };
}

