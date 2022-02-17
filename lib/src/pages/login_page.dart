import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:futbol593/src/bloc/login_bloc.dart';
import 'package:futbol593/src/models/usuario_model.dart';
import 'package:futbol593/src/providers/main_provider.dart';
import 'package:futbol593/src/services/usuario_service.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;
  final LoginBloc _loginBloc = LoginBloc();
  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.height;
    final mainProvider = Provider.of<MainProvider>(context, listen: true);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.yellow,
                      Colors.blue,
                      Colors.red,
                    ]
                  )
                ),
                height: size * 1,
              ),
              Padding(
                padding:const EdgeInsets.only(top: 80.0, left: 30.0, right: 30.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text("Inicio de Sesion",
                        style: Theme.of(context).textTheme.headline4!.apply(
                          color:Theme.of(context).scaffoldBackgroundColor,
                        ),      
                      ),
                    ),
                    Container(
                        height: 300.h,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).hintColor, width: 2.0
                          ),
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14.0, vertical: 25.0
                          ),
                          child: Column(
                            children: [
                              StreamBuilder<String>(
                                stream: _loginBloc.emailStream,
                                builder: (context, snapshot) {
                                  return TextField(
                                    keyboardType: TextInputType.emailAddress,
                                    onChanged: _loginBloc.changeEmail,
                                    decoration: InputDecoration(
                                      errorText: snapshot.error?.toString(),
                                      icon: const Icon(
                                        Icons.email_rounded,
                                        size: 30
                                      ),
                                      labelText: "Correo electronico",
                                      hintText: "usuario@gmail.com",
                                      hintMaxLines: 1,
                                    )
                                  );
                                }
                              ),
                              StreamBuilder<String>(
                                stream: _loginBloc.passwordStream,
                                builder: (context, snapshot) {
                                  return TextField(
                                    onChanged: _loginBloc.changePassword,
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
                                          size: 30
                                        )
                                      ),
                                      icon:const Icon(
                                        Icons.lock_outline_rounded,
                                        size: 30
                                      ),
                                      labelText: "Contraseña ",
                                    )
                                  );
                                }
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 30.0),
                                child: StreamBuilder<bool>(
                                  stream: _loginBloc.formLoginStream,
                                  builder: (context, snapshot) {
                                    return ElevatedButton.icon(
                                      onPressed: snapshot.hasData?
                                      ()async {
                                        final usrSrv = UsuarioService(); //Servicio
                                        final usr = Usuario(
                                            //Modelo
                                            email: _loginBloc.email,
                                            password: _loginBloc.password
                                        );
                                        Map<String, dynamic> resp =
                                            await usrSrv.login(usr);
                                        if (resp.containsKey("idToken")) {
                                          mainProvider.token =
                                              resp['idToken'];
                                        }
                                      } : null,
                                      icon:  Icon(Icons.login,
                                        size: 30,
                                        color: Theme.of(context).primaryColor
                                      ),
                                      label: Text("Ingresar",
                                        style: TextStyle(
                                          fontSize:20,
                                          color: Theme.of(context).primaryColor
                                        )
                                      )
                                    );
                                  }
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 25),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text("¿No tiene Cuenta?"),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pushNamed(context, "/signup");
                                      },
                                      child: Text("Registrese",style: TextStyle(color: Theme.of(context).primaryColor))
                                    )
                                  ]
                                ),
                              ),
                            ],
                          ),
                        ),
                    ),
                    Padding(
                      padding:const EdgeInsets.only(top: 50.0),
                      child: Image.asset('assets/images/logo.png',
                        height: 200.0,
                        width: 200.0
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
