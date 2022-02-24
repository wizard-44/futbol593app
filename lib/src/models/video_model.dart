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
        titulo: json["titulo"],
        descripcion: json["descripcion"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "titulo": titulo,
        "descripcion": descripcion,
        "url": url,
    };
}