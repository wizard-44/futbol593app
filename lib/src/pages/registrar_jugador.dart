import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:futbol593/src/models/jugador_model.dart';
import 'package:futbol593/src/services/jugador_services.dart';
import 'package:image_picker/image_picker.dart';

class RegistrarJugador extends StatefulWidget {
  const RegistrarJugador({Key? key, required this.idEquipo}) : super(key: key);
  final String idEquipo;

  @override
  _RegistrarJugadorState createState() => _RegistrarJugadorState();
}

class _RegistrarJugadorState extends State<RegistrarJugador> {
  late Jugador _jugador;
  File? _imagen;
  final ImagePicker _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  bool _onSaving = false;
  final JugadorService _jugadorService = JugadorService();

  @override
  void initState() {
    super.initState();
    _jugador = Jugador.created(widget.idEquipo);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Registro de Jugador"),
          elevation: 8,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back, size: 30),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 14.0),
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  width: size.width * .80,
                  decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                          width: 2.0, color: Theme.of(context).primaryColorDark)),
                  child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 14.0, horizontal: 7.0),
                        child: Column(children: [
                          TextFormField(
                              keyboardType: TextInputType.text,
                              initialValue: _jugador.nombre,
                              onSaved: (value) {
                                //Este evento se ejecuta cuando el Form ha sido guardado localmente
                                _jugador.nombre =
                                    value; //Asigna el valor del TextFormField al atributo del modelo
                              },
                              decoration: const InputDecoration(
                                labelText: "Ingrese el Nombre:",
                              ),
                              maxLength: 255,
                              maxLines: 1),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            onSaved: (value) {
                              //Este evento se ejecuta cuando el Form ha sido guardado localmente
                              _jugador.edad = int.parse(
                                  value!); //Asigna el valor del TextFormField al atributo del modelo
                            },
                            decoration: const InputDecoration(
                              labelText: "Ingrese la Edad:",
                            ),
                          ),
                          TextFormField(
                              keyboardType: TextInputType.text,
                              initialValue: _jugador.nacionalidad,
                              onSaved: (value) {
                                //Este evento se ejecuta cuando el Form ha sido guardado localmente
                                _jugador.nacionalidad =
                                    value; //Asigna el valor del TextFormField al atributo del modelo
                              },
                              decoration: const InputDecoration(
                                labelText: "Ingrese la Nacionalidad:",
                              ),
                              maxLength: 255,
                              maxLines: 1),
                          TextFormField(
                              keyboardType: TextInputType.text,
                              initialValue: _jugador.posicion,
                              onSaved: (value) {
                                //Este evento se ejecuta cuando el Form ha sido guardado localmente
                                _jugador.posicion =
                                    value; //Asigna el valor del TextFormField al atributo del modelo
                              },
                              decoration: const InputDecoration(
                                labelText: "Ingrese el Posicion:",
                              ),
                              maxLength: 255,
                              maxLines: 1
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.only(top: 10.0, bottom: 5),
                              child: Text("Seleccione la imagen",
                                  style: Theme.of(context).textTheme.subtitle1)),
                          SizedBox(
                              height: 100.h,
                              width: 160.h,
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: _imagen == null
                                    ? Image.asset('assets/images/logo.jpg')
                                    : Image.file(_imagen!),
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton.icon(
                                  onPressed: () =>
                                      _selectImage(ImageSource.camera),
                                  icon: const Icon(Icons.camera),
                                  label: const Text("Cámara")),
                              ElevatedButton.icon(
                                  onPressed: () =>
                                      _selectImage(ImageSource.gallery),
                                  icon: const Icon(Icons.image),
                                  label: const Text("Galería")),
                            ],
                          ),
                          Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10.0),
                              child: _onSaving
                                  ? const CircularProgressIndicator()
                                  : Tooltip(
                                      message: "Registrar Jugador",
                                      child: ElevatedButton.icon(
                                          onPressed: () {
                                            _sendForm();
                                          },
                                          label: const Text("Guardar"),
                                          icon: const Icon(Icons.save)),
                                    ))
                        ]),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _selectImage(ImageSource source) async {
    XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      _imagen = File(pickedFile.path);
    } else {
      _imagen = null;
      //print('No image selected.');
    }
    setState(() {});
  }

  _sendForm() async {
    if (!_formKey.currentState!.validate()) return;

    _onSaving = true;
    setState(() {});

    _formKey.currentState!.save(); //Guarda el form localmente

    if (_imagen != null) {
      _jugador.urlfoto = await _jugadorService.uploadImage(_imagen!);
      _jugador.numgoles = 0;
    }

    //Invoca al servicio POST para enviar la Foto
    int estado = await _jugadorService.postJugador(_jugador);

    if (estado == 201) {
      _formKey.currentState!.reset();
      _onSaving = false;
      Navigator.pop(context);
    }
  }
}
