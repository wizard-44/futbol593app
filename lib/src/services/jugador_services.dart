import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:futbol593/src/models/jugador_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class JugadorService {
  JugadorService();
  final String _rootUrl = "https://f593backend.web.app/api/jugador";

  Future<List<Jugador>?> getJugadores() async {
    List<Jugador> result = [];
    try {
      var url = Uri.parse(_rootUrl);
      final response = await http.get(url);
      if (response.body.isEmpty) return result;
      List<dynamic> listBody = json.decode(response.body);
      for (var item in listBody) {
        final jugador = Jugador.fromJson(item);
        result.add(jugador);
      }
      return result;
    } catch (ex) {
      // ignore: avoid_print
      print(ex);
      return result;
    }
  }

  Future<List<Jugador>?> get(String id) async {
    List<Jugador> result = [];
    try {
      var url = Uri.parse('$_rootUrl/$id');
      var response = await http.get(url);
      if (response.body.isEmpty) return result;
      List<dynamic> listBody = json.decode(response.body);
      for (var item in listBody) {
        var jugador = Jugador.fromJson(item);
        result.add(jugador);
      }
      return result;
    } catch (ex) {
      return null;
    }
  }

  Future<String> uploadImage(File image) async {
    final cloudinary =
        CloudinaryPublic('ddqtgttih', 'futbol593', cache: false);
    try {
      CloudinaryResponse response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(image.path,
            resourceType: CloudinaryResourceType.Image,
            folder: "futbol593/Jugadores/"),
      );
      return response.secureUrl;
    } on CloudinaryException catch (e) {
      return "" + e.toString();
    }
  }

  Future<int> postJugador(Jugador jugador) async {
    try {
      var uri = Uri.parse(_rootUrl);
      String _jugadorBody = jugadorToJson(jugador);
      final Map<String, String> _headers = {"content-type": "application/json"};
      var response = await http.post(uri, headers: _headers, body: _jugadorBody);
      if (response.body.isEmpty) return 400;
      Map<String, dynamic> content = json.decode(response.body);
      int result = content["estado"];
      return result;
    } catch (ex) {
      return 500;
    }
  }
}
