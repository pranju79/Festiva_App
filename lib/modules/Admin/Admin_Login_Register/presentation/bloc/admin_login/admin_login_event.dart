part of 'admin_login_bloc.dart';

abstract class AdminLoginEvent {}

class OnLoginEvent extends AdminLoginEvent {
  final AdminModel admin;

  OnLoginEvent({required this.admin});
}
