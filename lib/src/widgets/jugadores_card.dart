import 'package:flutter/material.dart';
import 'package:futbol593/src/models/jugador_model.dart';

class JugadoresCard extends StatelessWidget {
  const JugadoresCard({Key? key,required this.jugador }) : super(key: key);
  final Jugador jugador;

 @override
  Widget build(BuildContext context) {
    final urlfotojugador = jugador.urlfoto;
    return Card(
        elevation: 3,
        child: ListTile(
            leading: SizedBox(
              width: 60,
              height: 60,
              child: CircleAvatar(
                backgroundImage: NetworkImage(urlfotojugador ?? ""),
              ),
            ),
            title: Text(jugador.nombre ?? ""),
            subtitle: Text(jugador.edad.toString()),
            onTap: () {}
        ));
  }
}