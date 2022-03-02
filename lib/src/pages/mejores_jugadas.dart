import 'package:flutter/material.dart';
import 'package:futbol593/src/models/video_model.dart';
import 'package:video_player/video_player.dart';

class MejoresJugadas extends StatefulWidget {
  const MejoresJugadas({Key? key,required this.model}) : super(key: key);
  final Video model;
  @override
  MejoresJugadasState createState() => MejoresJugadasState();
}
 
class MejoresJugadasState extends State<MejoresJugadas> {
  Color mainColor = const Color(0xFF1A1C1E);
  VideoPlayerController? _controller;

   @override
  void initState() {
    super.initState();
    String dataSource= widget.model.url??" ";
    _controller=VideoPlayerController.network(dataSource)
    ..initialize().then((_){
      setState(() {
      });
    });
  }
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
      body:
      Column(
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
                 Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.model.titulo??" ",
                  style: const TextStyle(
                    color:Colors.white,
                     fontSize: 25,
                    fontWeight: FontWeight.bold
                  ),
                  ),
                ),
                 Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.model.descripcion??" ",
                  style: const TextStyle(
                    color:Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.normal
                  ),
                  ),
                ),
              ],
            ),
    );
  }
}