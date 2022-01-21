import 'package:flutter/material.dart';
import 'package:futbol593/src/models/equipo_model.dart';
import 'package:futbol593/src/pages/perfil_equipo_page.dart';

class EquiposCard extends StatelessWidget {
  const EquiposCard({ Key? key,required this.equipo }) : super(key: key);
  final Equipo equipo;

  @override
  Widget build(BuildContext context) {
    final urlFotoPerfil = equipo.urlfoto;
    return Card(
        elevation: 3,
        child: ListTile(
            leading: SizedBox(
              width: 60,
              height: 60,
              child: CircleAvatar(
                backgroundImage: NetworkImage(urlFotoPerfil ?? ""),
              ),
            ),
            title: Text(equipo.nombre ?? ""),
            subtitle: Text(equipo.historia ?? ""),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        PerfilEquipoPage(equipo: equipo)),
              );
            }));
  }
}