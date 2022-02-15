import 'package:flutter/material.dart';
import 'package:futbol593/src/models/equipo_model.dart';
import 'package:futbol593/src/models/jugador_model.dart';
import 'package:futbol593/src/services/jugador_services.dart';
import 'package:futbol593/src/widgets/jugadores_card.dart';

class JugadorListWidget extends StatefulWidget {
  const JugadorListWidget({Key? key,required this.equipo }) : super(key: key);
  final Equipo equipo;

  @override
  _JugadorListWidgetState createState() => _JugadorListWidgetState();
}

class _JugadorListWidgetState extends State<JugadorListWidget> {
  final JugadorService _jugadorService = JugadorService();
  List<Jugador>? _jugadores;

  @override
  void initState() {
    super.initState();
    _downloadJugador();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
              child: _jugadores == null
                  ? Center(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CircularProgressIndicator(
                          strokeWidth: 4.0,
                          color: Colors.indigo,
                        ),
                        Padding(padding: EdgeInsets.all(8.0)),
                        Text("Cargando Jugadores",
                            style: TextStyle(
                              fontSize: 25,
                            ))
                      ],
                    ))
                  : _jugadores!.isEmpty
                      ? const Center(
                          child: Text("No hay Jugadores Disponibles..."))
                      : ListView(
                          children: _jugadores!
                              .map((e) => JugadoresCard(jugador: e))
                              .toList(),
                        )
          )
        ]
      )
    );
  }

  _downloadJugador() async {
    String id = widget.equipo.idEquipo!;
    _jugadores = await _jugadorService.get(id);
    if (mounted) {
      setState(() {});
    }
  }
}