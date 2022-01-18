import 'package:flutter/material.dart';
import 'package:futbol593/src/providers/main_provider.dart';
import 'package:futbol593/src/widgets/menu_lateral.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    final mainProvider = Provider.of<MainProvider>(context, listen: true);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
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
          actions:<Widget>[
            Switch(
                value: mainProvider.mode,
                onChanged: (bool value) async {
                  mainProvider.mode = value;
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setBool("mode", value);
                }),
          ],
        ),
        drawer: MenuLateral(),
      ),
    );
  }
}