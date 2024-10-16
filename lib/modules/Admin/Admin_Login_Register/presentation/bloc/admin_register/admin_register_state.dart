part of 'admin_register_bloc.dart';

abstract class AdminRegisterState {}

final class AdminRegisterInitial extends AdminRegisterState {}

final class AdminRegisterLoading extends AdminRegisterState {}

final class AdminRegisterSuccess extends AdminRegisterState {
  String message;
  AdminRegisterSuccess({required this.message});
}

final class AdminRegisterFailure extends AdminRegisterState {
  String error;
  AdminRegisterFailure({required this.error});
}
