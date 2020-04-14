import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/app/app_store.dart';
import 'package:remessa_app/models/error_model.dart';
import 'package:remessa_app/services/auth_service.dart';
import 'package:remessa_app/services/system_service.dart';
import './bloc.dart';

class LoginScreenBloc extends Bloc<LoginScreenEvent, LoginScreenState> {
  final _appStore = GetIt.I<AppStore>();

  @override
  LoginScreenState get initialState => LoginScreenState();

  Stream<LoginScreenState> _mapLoginToState(LoginEvent event) async* {
    final formState = LoginScreenFormState(
      cpf: event.cpf,
      password: event.password,
    );

    yield LoginScreenState(
      success: false,
      isLoading: true,
      formState: formState,
    );

    try {
      await GetIt.I<AuthService>().login(event.cpf, event.password);

      _appStore.refreshIsLoggedIn();

      GetIt.I<SystemService>().setShowStepper(false);

      yield LoginScreenState(success: true);
    } on ErrorModel catch (e) {
      yield LoginScreenState(
        success: false,
        errorMessage: e?.mainError?.message,
        formState: formState..clearPassword(),
      );
    } on DioError catch (e) {
      yield LoginScreenState(
        success: false,
        errorMessage: e.error,
      );
    } catch (e) {
      yield LoginScreenState(
        success: false,
        errorMessage: e.error,
      );
    }
  }

  @override
  Stream<LoginScreenState> mapEventToState(
    LoginScreenEvent event,
  ) async* {
    if (event is LoginEvent) {
      yield* _mapLoginToState(event);
    }
  }
}
