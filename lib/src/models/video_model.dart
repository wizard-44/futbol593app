import 'dart:convert';

Video videoFromJson(String str) => Video.fromJson(json.decode(str));

String videoToJson(Video data) => json.encode(data.toJson());

class Video {
    Video({
        this.titulo,
        this.descripcion,
        this.url,
    });

    String? titulo;
    String? descripcion;
    String? url;

    factory Video.fromJson(Map<String, dynamic> json) => Video(
        titulo: json["Titulo"],
        descripcion: json["Descripcion"],
        url: json["Url"],
    );

    Map<String, dynamic> toJson() => {
        "Titulo": titulo,
        "Descripcion": descripcion,
        "Url": url,
    };
}