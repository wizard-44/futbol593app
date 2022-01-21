import 'package:flutter/material.dart';
import 'package:futbol593/src/models/equipo_model.dart';
import 'package:futbol593/src/widgets/jugador_list_widget.dart';
import 'package:futbol593/src/widgets/more_details_equipos_widget.dart';

class EquipoDetallesWidget extends StatefulWidget {
  const EquipoDetallesWidget({Key? key, required this.equipo}) : super(key: key);
  final Equipo equipo;
  @override
  _EquipoDetallesWidgetState createState() => _EquipoDetallesWidgetState();
}

class _EquipoDetallesWidgetState extends State<EquipoDetallesWidget>
    with SingleTickerProviderStateMixin {
  final List<Tab> _tabs = <Tab>[
    const Tab(
      text: "Detalles",
    ),
    const Tab(text: "Jugadores"),
  ];

  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: _tabs.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TabBar(
          tabs: _tabs,
          controller: _tabController,
          labelColor: Colors.blue,
        ),
        body: TabBarView(children: [
          MoreDetailsEquipoWidget(equipo: widget.equipo),
          JugadorListWidget(equipo: widget.equipo),
        ], controller: _tabController));
  }
}