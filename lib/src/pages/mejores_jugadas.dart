import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dart:developer' as developer;

class MejoresMomentos extends StatefulWidget {
  const MejoresMomentos({Key? key}) : super(key: key);
 
  @override
  MejoresMomentosState createState() => MejoresMomentosState();
}
 
class MejoresMomentosState extends State<MejoresMomentos> {
  Color mainColor = const Color(0xFF1A1C1E);
  String dataSource="https://res.cloudinary.com/infosof/video/upload/v1645664235/Videos/Mejores_Jugadas_bz8zjf.mp4";
  VideoPlayerController? _controller;

   @override
  void initState() {
    super.initState();
    _controller=VideoPlayerController.network(dataSource)
    ..initialize().then((_){
      setState(() {
      });
    });
  }
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
            _controller!.pause();
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
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _controller!.value.isInitialized
                ?AspectRatio(aspectRatio: _controller!.value.aspectRatio,
                child:VideoPlayer(_controller!),)
                :Container(),
                VideoProgressIndicator(
                  _controller!, 
                  allowScrubbing: true,
                  padding: const EdgeInsets.all(0.0),          
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  FloatingActionButton(
                    onPressed: () {
                      // Envuelve la reproducción o pausa en una llamada a `setState`. Esto asegura
                      // que se muestra el icono correcto
                      setState(() {
                        // Si el vídeo se está reproduciendo, pausalo.
                        if (_controller!.value.isPlaying) {
                          _controller!.pause();
                        } else {
                          // Si el vídeo está pausado, reprodúcelo
                          _controller!.play();
                        }
                      });
                    },
                    // Muestra el icono correcto dependiendo del estado del vídeo.
                    child: Icon(
                      _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
                    ),
                  ),
                ],
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Mejor Momentos de la Fecha 5",
                  style: TextStyle(
                    color:Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.normal
                  ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Los 5 Mejores Momentos de la Fecha 5. Liga Pro.",
                  style: TextStyle(
                    color:Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.normal
                  ),
                  ),
                ),
              ],
            );
          }
          return const SizedBox();
        }
      ),
    );
  }
}