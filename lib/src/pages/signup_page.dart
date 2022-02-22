// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:futbol593/src/bloc/signup_bloc.dart';
import 'package:futbol593/src/models/usuario_model.dart';
import 'package:futbol593/src/services/usuario_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _obscureText = true;
  final SignUpBloc _signUpBloc = SignUpBloc();

  final List<String> _roles = ["Administrador", "Supervisor"];
  String _roleSelected = "Administrador";

  final UsuarioService _usrServ = UsuarioService();

  String Fotourl = 'assets/images/user.png';
  File? _imagen;
  final ImagePicker _picker = ImagePicker();
  String? FechaNac;
  DateTime date = DateTime.now();
  var formatter = DateFormat('yyyy-MM-dd');
  DateTime fromDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  Future<DateTime> selectDate(BuildContext context, DateTime _date) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      _date = picked;
    }
    return _date;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                  Colors.yellow,
                  Colors.blue,
                  Colors.red,
                ])),
            height: size * 1,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 80.0, left: 35.0, right: 35.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text("Registro de usuario",
                      style: Theme.of(context).textTheme.headline4!.apply(
                          color: Theme.of(context).scaffoldBackgroundColor)),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).hintColor, width: 2.0),
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        StreamBuilder<String>(
                            stream: _signUpBloc.usernameStream,
                            builder: (context, snapshot) {
                              return TextField(
                                  keyboardType: TextInputType.text,
                                  onChanged: _signUpBloc.changeUsername,
                                  decoration: InputDecoration(
                                      errorText: snapshot.error?.toString(),
                                      icon: const Icon(Icons.person, size: 30),
                                      labelText: "Nombre",
                                      hintText: "Nombre y apellido"));
                            }),
                        StreamBuilder<String>(
                            stream: _signUpBloc.emailStream,
                            builder: (context, snapshot) {
                              return TextField(
                                  keyboardType: TextInputType.emailAddress,
                                  onChanged: _signUpBloc.changeEmail,
                                  decoration: InputDecoration(
                                      errorText: snapshot.error?.toString(),
                                      icon: const Icon(Icons.email, size: 30),
                                      labelText: "Correo electrónico",
                                      hintText: "admin@trifasic.com"));
                            }),
                        StreamBuilder<String>(
                            stream: _signUpBloc.passwordStream,
                            builder: (context, snapshot) {
                              return TextField(
                                  keyboardType: TextInputType.text,
                                  onChanged: _signUpBloc.changePassword,
                                  obscureText: _obscureText,
                                  decoration: InputDecoration(
                                      errorText: snapshot.error?.toString(),
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                            _obscureText = !_obscureText;
                                            setState(() {});
                                          },
                                          icon: Icon(
                                              _obscureText
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                              size: 30)),
                                      icon: const Icon(Icons.lock, size: 30),
                                      labelText: "Contraseña"));
                            }),
                        Row(
                          children: <Widget>[
                            const Text(
                              'Fecha de Nacimiento:',
                            ),
                            IconButton(
                              icon: const Icon(Icons.calendar_today),
                              onPressed: () async {
                                DateTime? newDate = await showDatePicker(
                                    context: context,
                                    initialDate: date,
                                    firstDate: DateTime(1950),
                                    lastDate: DateTime.now(),
                                    confirmText: "Aceptar",
                                    cancelText: "Cancelar");

                                if (newDate == null) return;

                                setState(() {
                                  date = newDate;
                                  FechaNac = date.toString();
                                });
                              },
                            ),
                            Text(formatter.format(date)),
                          ],
                        ),
                        Padding(
                          padding:const EdgeInsets.only(top: 10.0, bottom: 5),
                          child: Text("Seleccione una imagen",
                            style: Theme.of(context).textTheme.subtitle1
                          )
                        ),
                        SizedBox(
                            height: 100.h,
                            width: 160.h,
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: _imagen == null
                                  ? Image.asset('assets/images/user.png')
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
                          padding:const EdgeInsets.only(top: 10.0, bottom: 5),
                          child: Text("Seleccione su Rol",
                              style: Theme.of(context).textTheme.subtitle1
                          )
                        ),
                        DropdownButton<String>(
                            onChanged: (String? newValue) {
                              _roleSelected = newValue!;
                              setState(() {});
                            },
                            value: _roleSelected,
                            icon: Icon(Icons.arrow_downward,
                                size: 25,
                                color: Theme.of(context).primaryColor),
                            elevation: 16,
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 18,
                            ),
                            underline: Container(height: 2),
                            items: _roles
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList()),
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: StreamBuilder<bool>(
                              stream: _signUpBloc.formSignUpStream,
                              builder: (context, snapshot) {
                                return ElevatedButton.icon(
                                  onPressed: snapshot.hasData
                                    ? () async {
                                      if (_imagen != null) {
                                        Fotourl = await _usrServ.uploadImage(_imagen!);
                                      } else {
                                        Fotourl ="https://res.cloudinary.com/ddqtgttih/image/upload/v1645537641/Futbol593/Usuarios/user_bhnlvb.png";
                                      }
                                      Usuario usr = Usuario(
                                        role: _roleSelected,
                                        displayName:_signUpBloc.username,
                                        email: _signUpBloc.email,
                                        password: _signUpBloc.password,
                                        fechaNacimiento: FechaNac,
                                        foto: Fotourl
                                      );
                                      int result = await _usrServ.postUsuario(usr);
                                      if (result == 201) {
                                        Navigator.pop(context);
                                        final snackBar = SnackBar(
                                          content: const Text('Se ha Registrado Correctamente'),
                                          duration: const Duration(seconds: 6),
                                          width: 280.0, // Width of the SnackBar.
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, // Inner padding for SnackBar content.
                                          ),
                                          backgroundColor: Colors.teal,
                                          behavior: SnackBarBehavior.floating,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                        );
                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                      }
                                    }
                                    : null,
                                    icon: Icon(
                                      Icons.login,
                                      size: 30,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    label: Text("Registrar",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Theme.of(context).primaryColor,
                                      )
                                    )
                                );
                              }),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    )));
  }

  _selectImage(ImageSource source) async {
    XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      _imagen = File(pickedFile.path);
      final snackBar = SnackBar(
        content: const Text('Imagen seleccionada correctamente'),
        duration: const Duration(seconds: 6),
        width: 280.0, // Width of the SnackBar.
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0, // Inner padding for SnackBar content.
        ),
        backgroundColor: Colors.teal,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      _imagen = null;
      final snackBar = SnackBar(
        content: const Text('No se selecciono ninguna imagen'),
        duration: const Duration(seconds: 6),
        width: 280.0, // Width of the SnackBar.
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0, // Inner padding for SnackBar content.
        ),
        backgroundColor: Colors.teal,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    setState(() {});
  }
}
