import 'package:futbol593/src/bloc/validator_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class SignUpBloc with Validator {
  SignUpBloc();
  //Controllers
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _usernameController = BehaviorSubject<String>();
  //Streams, vinculados con la validación
  Stream<String> get emailStream =>
      _emailController.stream.transform(emailValidator);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(passwordValidator);
  Stream<String> get usernameStream =>
      _usernameController.stream.transform(usernameValidator);
  Stream<bool> get formSignUpStream => Rx.combineLatest3(
      usernameStream,
      emailStream,
      passwordStream,
       (a, b, c) => true
  );
  //Funciones para el onChange cada control
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(String) get changeUsername => _usernameController.sink.add;
  //Propiedades con el valor del texto ingreso
  String get email => _emailController.value;
  String get password => _passwordController.value;
  String get username => _usernameController.value;
}