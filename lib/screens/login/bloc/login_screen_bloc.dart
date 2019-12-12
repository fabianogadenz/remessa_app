import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/app/bloc/bloc.dart';
import 'package:remessa_app/models/error_model.dart';
import 'package:remessa_app/services/auth_service.dart';
import './bloc.dart';

class LoginScreenBloc extends Bloc<LoginScreenEvent, LoginScreenState> {
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

      GetIt.I<AppBloc>().add(RefreshLoginEvent());

      yield LoginScreenState(success: true);
    } on ErrorModel catch (e) {
      yield LoginScreenState(
        success: false,
        errorMessage: e?.mainError?.message,
        formState: formState..clearPassword(),
      );
    } catch (e) {
      yield LoginScreenState(success: false, errorMessage: e?.message);
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
