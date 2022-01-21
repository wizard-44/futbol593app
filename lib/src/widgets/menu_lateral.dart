import 'package:flutter/material.dart';
import 'package:futbol593/src/pages/home_page.dart';
import 'package:futbol593/src/widgets/equipos_list.dart';

class MenuLateral extends StatelessWidget {
  const MenuLateral({Key? key}) : super(key: key);

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
                onTap: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const HomePage()));
                }
            ),
            ListTile(
            leading: const Icon(Icons.calendar_today_rounded),
            title: const Text('Calendario'),
            onTap: () {}
            ),
            ListTile(
            leading: const Icon(Icons.group_work_rounded),
            title: const Text('Equipos'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const EquipoListCard()),
              );
            }
            ),
            ListTile(
              leading: const Icon(Icons.pivot_table_chart_rounded),
              title: const Text('Tabla Posiciones'),
              onTap: () {}
            ),
            ListTile(
              leading: const Icon(Icons.account_box_rounded),
              title: const Text('Registrarse'),
              onTap: () {}
            ),
      ]),
    );
  }
}