part of 'admin_register_bloc.dart';

abstract class AdminRegisterEvent {}

final class OnRegisterEvent extends AdminRegisterEvent {
  final AdminModel admin;
  OnRegisterEvent({required this.admin});
}
