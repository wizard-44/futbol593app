import 'package:flutter/material.dart';
import 'package:futbol593/src/models/equipo_model.dart';

class MoreDetailsEquipoWidget extends StatelessWidget {
  const MoreDetailsEquipoWidget({Key? key, required this.equipo}) : super(key: key);
  final Equipo equipo;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(children: [
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text("Historia:"),
            subtitle: Text(equipo.historia ?? ""),
          ),
        ]),
      ),
    );
  }
}