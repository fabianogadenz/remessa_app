import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class LoginScreenEvent extends Equatable {
  const LoginScreenEvent();
}

class LoginEvent extends LoginScreenEvent {
  final String cpf;
  final String password;

  LoginEvent({
    @required this.cpf,
    @required this.password,
  })  : assert(cpf != null && cpf.isNotEmpty),
        assert(password != null && password.isNotEmpty);

  @override
  List<Object> get props => [cpf, password];
}
