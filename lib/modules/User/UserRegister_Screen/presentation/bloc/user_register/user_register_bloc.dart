import 'dart:async';
import 'package:event_orientation_app/modules/User/UserRegister_Screen/presentation/bloc/user_register/user_register_event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'user_register_state.dart';

class UserRegisterBloc extends Bloc<UserRegisterEvent, UserRegisterState> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController GenderController = TextEditingController();
  final TextEditingController PassController = TextEditingController();
  final TextEditingController ConformPassController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  UserRegisterBloc() : super(UserRegisterInitial()) {
    on<UserRegisterEvent>((event, emit) {});
    on<OnSubmitEvent>(OnSubmit);
  }
  FutureOr<void> OnSubmit(
      OnSubmitEvent event, Emitter<UserRegisterState> emit) async {
    emit(UserRegisterLoading());

    if (event.user.password != event.user.conformPass) {
      emit(UserRegisterError(error: "password must be same"));
      return;
    }

    try {
      await firestore.collection('UserRegister').add({
        'Name': event.user.name,
        'Email': event.user.email,
        'MobileNo': event.user.mobile,
        'gender': event.user.gender,
        'Password': event.user.password,
      });
      emit(UserRegisterSuccess());
    } catch (error) {
      emit(UserRegisterFailure(message: 'Something Went wrong!'));
    }
  }
}
