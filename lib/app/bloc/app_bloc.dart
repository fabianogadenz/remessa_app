import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/services/auth_service.dart';
import './bloc.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final _authService = GetIt.I<AuthService>();

  @override
  AppState get initialState => AppState(isLoggedIn: _authService.isLoggedIn);

  @override
  Stream<AppState> mapEventToState(
    AppEvent event,
  ) async* {
    if (event is RefreshLoginEvent) {
      yield AppState(isLoggedIn: _authService.isLoggedIn);
    }
  }
}
