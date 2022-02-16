import 'package:flutter/material.dart';
import 'package:futbol593/src/providers/main_provider.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    Map<String, dynamic> content = JwtDecoder.decode(mainProvider.token);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/letras.png',
                fit: BoxFit.contain,
                height: 200,
                width: 200,
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                mainProvider.token = "";
                Navigator.pop(context);
              },
              icon: const Icon(Icons.logout),
              tooltip: "Cerrar Sesión",
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(children: [
            const Padding(
              padding: EdgeInsets.only(top: 25,bottom: 25),
              child: Center(
                child: Text(
                  "Mi Cuenta",
                  style:TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                  ),
                  textAlign: TextAlign.left,
                )
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.account_box,
                  size: 35,
                ),
                title: Text(content["name"]),
                subtitle: const Text("Nombre Usuario")
              )
            ),
            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.computer,
                  size: 35
                ),
                title: Text(content["role"].toString().toUpperCase()),
                subtitle: const Text("Rol")
              )
            ),
            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.important_devices,
                  size: 35
                ),
                title: Text(content["user_id"]),
                subtitle: const Text("Id")
              )
            ),
            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.email,
                  size: 35
                ),
                title: Text(content["email"]),
                subtitle: const Text("Correo electrónico")
              )
            ),
            const Padding(
              padding: EdgeInsets.only(top: 25,bottom: 25),
              child: Center(
                child: Text(
                  "Ajustes",
                  style:TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                  ),
                  textAlign: TextAlign.left,
                )
              ),
            ),
            const SettingMode()
          ]),
        ),
      ),
    );
  }
}


class SettingMode extends StatelessWidget {
  const SettingMode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context);
    return Card(
      child: ListTile(
        leading: const Icon(Icons.light_mode,size: 35),
        title: const Text("Modo Claro"),
        subtitle: const Text("Habilitar / Deshabilitar"),
        trailing: Switch(
          value: mainProvider.mode,
          onChanged: (bool value) async {
            mainProvider.mode = value;
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool("mode", value);
          }
        ),
      ),
    );
  }
}
