import 'dart:async';
import 'dart:developer' as developer;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:futbol593/src/models/estadio_model.dart';
import 'package:futbol593/src/widgets/menu_lateral.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EstadioPage extends StatefulWidget {
  const EstadioPage({Key? key}) : super(key: key);

  @override
  _EstadioPageState createState() => _EstadioPageState();
}

class _EstadioPageState extends State<EstadioPage> {
  final Completer<GoogleMapController> _controller = Completer();

  final CameraPosition _kLatacunga = const CameraPosition(
    target: LatLng(-0.9333, -78.6185),
    zoom: 14,
  );

  final Stream<QuerySnapshot> _estadioStrem =
      FirebaseFirestore.instance.collection('Estadios').snapshots();
  @override
  Widget build(BuildContext context) {
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
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: _estadioStrem,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                developer.log(snapshot.toString());
                return const Center(
                  child:
                      SizedBox(child: Text('Error al consultar los estadios.')),
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
                Set<Marker> kMnts =
                    snapshot.data!.docs.map((DocumentSnapshot document) {
                  Estadio model =
                      Estadio.fromJson(document.data() as Map<String, dynamic>);
                  Marker marker = Marker(
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueYellow),
                      infoWindow: InfoWindow(title: model.nombre),
                      markerId: const MarkerId("Ubicacion"),
                      position:
                          LatLng(model.lat ?? -0.9333, model.lng ?? -78.6185));
                  return marker;
                }).toSet();
                return GoogleMap(
                  markers: kMnts,
                  mapType: MapType.terrain,
                  initialCameraPosition: _kLatacunga,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                );
              }
              return const SizedBox();
            }),
        drawer: const MenuLateral(),
      ),
    );
  }
}
