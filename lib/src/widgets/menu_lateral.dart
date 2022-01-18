import 'package:flutter/material.dart';
import 'package:futbol593/src/pages/registrar_page.dart';

class MenuLateral extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(padding: EdgeInsets.zero, children: [
        DrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(3, 4, 94, 1),
            ),
            child: Column(children: [
              Expanded(
                child: Image.asset('assets/images/logo.png'),
              ),
              const SizedBox(
                height: 10.0,
              ),
            ])),
            ListTile(
                leading: const Icon(Icons.airplay_rounded),
                title: const Text('Inicio'),
                onTap: () {}
            ),
            ListTile(
            leading: const Icon(Icons.calendar_today_rounded),
            title: const Text('Calendario'),
            onTap: () {}
            ),
            ListTile(
            leading: const Icon(Icons.group_work_rounded),
            title: const Text('Equipos'),
            onTap: () {}
            ),
            ListTile(
            leading: const Icon(Icons.pivot_table_chart_rounded),
            title: const Text('Tabla Posiciones'),
            onTap: () {}
            ),
            ListTile(
            leading: const Icon(Icons.account_box_rounded),
            title: const Text('Registrarse'),
            onTap:() {}
            ),
      ]),
    );
  }
}