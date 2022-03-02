import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:futbol593/src/models/video_model.dart';
import 'package:futbol593/src/pages/mejores_jugadas.dart';
import 'dart:developer' as developer;

class MejoresMomentos extends StatefulWidget {
  const MejoresMomentos({Key? key}) : super(key: key);
 
  @override
  MejoresMomentosState createState() => MejoresMomentosState();
}
 
class MejoresMomentosState extends State<MejoresMomentos> {
  Color mainColor = const Color(0xFF1A1C1E);

  final Stream<QuerySnapshot> _videosStrem = FirebaseFirestore.instance.collection('Videos').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        backgroundColor:mainColor,
        elevation:0.0,
        title: const Text("Mejores Momentos"),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _videosStrem,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
                developer.log(snapshot.toString());
                return const Center(
                  child:
                      SizedBox(child: Text('Error al consultar las mejores jugadas.')),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: SizedBox(
                      height: 50.0,
                      width: 50.0,
                      child: CircularProgressIndicator()),
                );
              }
              
          if (snapshot.hasData) {
            return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
                  Video model = Video.fromJson(data);
                  return Card(
                  child: ListTile(
                      onTap: () {
                        Navigator.push<void>(
                          context,
                          MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  MejoresJugadas(model: model)),
                        );
                      },
                      leading: const Icon(Icons.ondemand_video),
                      title: Text(model.titulo ?? ""),
                      subtitle: Text(model.descripcion ?? ""),
                                  ));
                          }).toList(),
              );
          }
          return const SizedBox();
        }
      ),
    );
  }
}