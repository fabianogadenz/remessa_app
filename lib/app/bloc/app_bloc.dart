import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/services/auth_service.dart';
import './bloc.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final _authService = GetIt.I<AuthService>();

  @override
  AppState get initialState => AppState(isLoggedIn: _authService.isLoggedIn);

  Stream<AppState> _mapLogoutEventToState() async* {
    _authService.logout();

    yield AppState(isLoggedIn: false);
  }

  @override
  Stream<AppState> mapEventToState(
    AppEvent event,
  ) async* {
    if (event is RefreshLoginEvent)
      yield AppState(isLoggedIn: _authService.isLoggedIn);
    if (event is LogoutEvent) yield* _mapLogoutEventToState();
  }
}
