class LoginScreenFormState {
  final String cpf;
  String password;

  LoginScreenFormState({
    this.cpf = '',
    this.password = '',
  });

  clearPassword() {
    this.password = '';
  }
}

class LoginScreenState {
  final bool success;
  final String errorMessage;
  final bool isLoading;
  final LoginScreenFormState formState;

  LoginScreenState({
    this.success = false,
    this.errorMessage,
    this.isLoading = false,
    this.formState,
  });
}
