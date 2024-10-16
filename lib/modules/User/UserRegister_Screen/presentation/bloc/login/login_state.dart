abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
final String email;

LoginSuccess({required this.email});
}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure({required this.error});
}