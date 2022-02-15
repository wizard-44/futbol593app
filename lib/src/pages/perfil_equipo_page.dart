import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:futbol593/src/models/equipo_model.dart';
import 'package:futbol593/src/pages/registrar_jugador.dart';
import 'package:futbol593/src/widgets/equipo_detalles_widget.dart';

class PerfilEquipoPage extends StatelessWidget {
  const PerfilEquipoPage({ Key? key, required this.equipo }) : super(key: key);
  final Equipo equipo;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              pinned: true,
              expandedHeight: 180.h,
              flexibleSpace: FlexibleSpaceBar(
                  title: Text(equipo.nombre ?? "",
                      overflow: TextOverflow.ellipsis),
                  background: Image(
                      image: NetworkImage(equipo.urlfoto ?? ""),
                      fit: BoxFit.contain)),
            ),
            SliverFillRemaining(
              child: EquipoDetallesWidget(equipo: equipo)
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          tooltip: "Añadir Jugador",
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => RegistrarJugador(
                      idEquipo: equipo.idEquipo ?? "")
              ),
            );
          },
        ),
      )
    );
  }
}