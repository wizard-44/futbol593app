import 'package:futbol593/src/models/equipo_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EquipoService {
  EquipoService();
  final String _rootUrl =
      "https://f593backend.web.app/api/equipo";

  Future<List<Equipo>?> getEquipos() async {
    List<Equipo> result = [];
    try {
      var url = Uri.parse(_rootUrl);
      final response = await http.get(url);
      if (response.body.isEmpty) return result;
      List<dynamic> listBody = json.decode(response.body);
      for (var item in listBody) {
        final equipo = Equipo.fromJson(item);
        result.add(equipo);
      }
      return result;
    } catch (ex) {
      // ignore: avoid_print
      print(ex);
      return result;
    }
  }
}
