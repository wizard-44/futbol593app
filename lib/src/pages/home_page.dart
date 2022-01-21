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
        body:Center(
          child:Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                        width: 2.0, color: Theme.of(context).primaryColorDark)),
                child:Column(
                  children:const[
                    Image(image:NetworkImage("data:image/png;base64,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")),Text("Equipos"),
                  ]
                )
              )
            ],
          ),
        ),
        drawer: MenuLateral(),

      ),
    );
  }
}