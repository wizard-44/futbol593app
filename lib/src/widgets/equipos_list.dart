import 'package:flutter/material.dart';
import 'package:futbol593/src/models/equipo_model.dart';
import 'package:futbol593/src/services/equipo_services.dart';
import 'package:futbol593/src/widgets/equipos_card.dart';

class EquipoListCard extends StatefulWidget {
  const EquipoListCard({ Key? key }) : super(key: key);
  

  @override
  State<EquipoListCard> createState() => _EquipoListCardState();
}

class _EquipoListCardState extends State<EquipoListCard> {
  final EquipoService _equipoService = EquipoService();
  List<Equipo>? _equipos;

  @override
  void initState() {
    super.initState();
    _downloadEquipo();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Equipos"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                  child: _equipos == null
                      ? Center(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            CircularProgressIndicator(
                              strokeWidth: 4.0,
                              color: Colors.indigo,
                            ),
                            Padding(padding: EdgeInsets.all(8.0)),
                            Text("Cargando Equipos",
                                style: TextStyle(
                                  fontSize: 25,
                                ))
                          ],
                        ))
                      : _equipos!.isEmpty
                          ? const Center(
                              child: Text("No hay Equipos Disponibles..."))
                          : ListView(
                              children: _equipos!
                                  .map((e) => EquiposCard(equipo: e))
                                  .toList(),
                            )
              )
            ]
          )
        ),
      ),
    );
  }

  _downloadEquipo() async {
    _equipos = await _equipoService.getEquipos();
    if (mounted) {
      setState(() {});
    }
  }
}
