// ignore_for_file: file_names

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:futbol593/src/pages/home_page.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    
    super.initState();
    Timer(const Duration(seconds:5), ()=>Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>const HomePage())));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end:Alignment.bottomRight,
            colors:[
              Color.fromRGBO(0, 0, 0,1),
              Color.fromRGBO(0, 0, 0,1),
            ]
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/icons/logo.gif', height: 350.0, width: 350.0,)
          , const CircularProgressIndicator(
              color: Colors.indigo,
            ),
          ],
        ),
      )
    );
  }
}