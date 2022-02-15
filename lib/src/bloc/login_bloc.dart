import 'package:futbol593/src/bloc/validator_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class LoginBloc with Validator {
  LoginBloc();
  //Controllers
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  //Streams, vinculados con la validación
  Stream<String> get emailStream =>
      _emailController.stream.transform(emailValidator);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(passwordValidator);
  Stream<bool> get formLoginStream =>
      Rx.combineLatest2(emailStream, passwordStream, (a, b) => true);
  //Funciones para el onChange cada control
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  //Propiedades con el valor del texto ingreso
  String get email => _emailController.value;
  String get password => _passwordController.value;
}
