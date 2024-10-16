part of 'admin_login_bloc.dart';

abstract class AdminLoginState {}

class AdminLoginInitial extends AdminLoginState {}

class AdminLoginLoading extends AdminLoginState {}

class AdminLoginSuccess extends AdminLoginState {
  final String email;

  AdminLoginSuccess({required this.email});
}

class AdminLoginFailure extends AdminLoginState {
  final String error;

  AdminLoginFailure({required this.error});
}
