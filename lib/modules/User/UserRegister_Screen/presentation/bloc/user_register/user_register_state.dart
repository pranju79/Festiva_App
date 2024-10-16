part of 'user_register_bloc.dart';

abstract class UserRegisterState {}

final class UserRegisterInitial extends UserRegisterState {}
final class UserRegisterLoading extends UserRegisterState {}
final class UserRegisterSuccess extends UserRegisterState {

}


final class UserRegisterError extends UserRegisterState {

String error;
UserRegisterError({required this.error});
}
 final class UserRegisterFailure extends UserRegisterState{
 String message;
UserRegisterFailure({required this.message});
 }

 