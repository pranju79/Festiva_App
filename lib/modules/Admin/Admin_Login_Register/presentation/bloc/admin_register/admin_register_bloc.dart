import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_orientation_app/modules/Admin/admin_login_register/data/models/admin_model.dart';
import 'package:flutter/material.dart';

part 'admin_register_event.dart';
part 'admin_register_state.dart';

class AdminRegisterBloc extends Bloc<AdminRegisterEvent, AdminRegisterState> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobilenoController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  AdminRegisterBloc() : super(AdminRegisterInitial()) {
    on<AdminRegisterEvent>((event, emit) {});
    on<OnRegisterEvent>(onPressed);
  }

  FutureOr<void> onPressed(
      OnRegisterEvent event, Emitter<AdminRegisterState> emit) async {
    emit(AdminRegisterLoading());

    try {
      await firestore.collection('admin_register').add({
        'name': event.admin.name,
        'email': event.admin.email,
        'mobileno': event.admin.mobileno,
        'password': event.admin.password,
      });

      emit(AdminRegisterSuccess(message: 'Registration Successful'));
    } catch (e) {
      emit(AdminRegisterFailure(error: 'Error Occurred!'));
    }
  }
}
