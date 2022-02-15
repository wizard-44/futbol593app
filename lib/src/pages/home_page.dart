import 'package:flutter/material.dart';
import 'package:futbol593/src/widgets/equipos_list.dart';
import 'package:futbol593/src/widgets/menu_lateral.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        endDrawer: Drawer(
          child: ListView(
            children: [
              Card(
                child: ListTile(
                  leading: const Icon(Icons.settings),
                  onTap: () => Navigator.pushNamed(context, "/settings"),
                  title: const Text("Ajustes"),
                ),
              )
            ],
          ),
        ),
        appBar: AppBar(
          actions: [
            Builder(
              builder: (context) => IconButton(
                    icon: const Icon(Icons.app_settings_alt_rounded),
                    onPressed: () => Scaffold.of(context).openEndDrawer(),
                    tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              ),
            ),
          ],
          title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  Image.asset('assets/images/letras.png',
                  fit: BoxFit.contain,     
                  height: 200,
                  width: 200,
              ),
            ],
          ),
        ),
        body: Center(
          child: Container(
            padding: const EdgeInsets.only(top: 25),
            child: InkWell(
              splashColor: Colors.amber, // Splash color
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const EquipoListCard()),
                );
              },
              child: Column(
                children:const[
                  Image(
                    image:NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvccdyAyEvcR5WNnpEzZoNabvywQVJx0FeqA&usqp=CAU"),
                    width: 100,
                  ),
                  Text("Equipos",style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 30,
                    color: Colors.black),
                  ),
                ]
              ),
            ),
          ),
        ),
        drawer: const MenuLateral(),
      ),
    );
  }
}