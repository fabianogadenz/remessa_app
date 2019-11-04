import 'package:equatable/equatable.dart';

class AppState extends Equatable {
  final isLoggedIn;

  AppState({this.isLoggedIn = false});

  @override
  List<Object> get props => [isLoggedIn];
}
