import 'dart:convert';
import 'dart:developer' as developer;
import 'package:futbol593/src/models/usuario_model.dart';
import 'package:http/http.dart' as http;

class UsuarioService {
  UsuarioService();

  final String _urlRoot = "https://f593backend.web.app/api/registro";
  final String _firebaseAPIKey = 'AIzaSyDh6rDB3EKLahRnkbo1sA0jkXF79R1V0MQ';

  Future<Map<String, dynamic>> login(Usuario usuario) async {
    try {
      final loginBody = {
        "email": usuario.email,
        "password": usuario.password,
        "returnSecureToken": true
      };
      final queryParams = {"key": _firebaseAPIKey};
      var uri = Uri.https("www.googleapis.com",
        "/identitytoolkit/v3/relyingparty/verifyPassword", queryParams
      );
      var response = await http.post(uri, body: json.encode(loginBody));
      if (response.body.isEmpty) return <String, dynamic>{};
      Map<String, dynamic> decodedResp = json.decode(response.body);
      developer.log(decodedResp.toString());
      return decodedResp;
    } catch (e) {
      developer.log(e.toString());
      return <String, dynamic>{};
    }
  }

  Future<int> postUsuario(Usuario usuario) async {
    try {
      var uri = Uri.parse(_urlRoot);
      String usuarioBody = usuarioToJson(usuario);
      final Map<String, String> _headers = {"content-type": "application/json"};
      var response = await http.post(uri, headers: _headers, body: usuarioBody);
      if (response.body.isEmpty) return 400;
      Map<String, dynamic> content = json.decode(response.body);
      int result = content["estado"];
      developer.log("Estado $result");
      return result;
    } catch (ex) {
      developer.log("Error $ex");
      return 500;
    }
  }
}
