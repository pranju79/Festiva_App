import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_orientation_app/modules/Admin/Admin_Login_Register/data/models/admin_model.dart';
import 'package:flutter/material.dart';

part 'admin_login_event.dart';
part 'admin_login_state.dart';

class AdminLoginBloc extends Bloc<AdminLoginEvent, AdminLoginState> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  AdminLoginBloc() : super(AdminLoginInitial()) {
    on<AdminLoginEvent>((event, emit) {});
    on<OnLoginEvent>(onPressed);
  }

  FutureOr<void> onPressed(
      OnLoginEvent event, Emitter<AdminLoginState> emit) async {
    emit(AdminLoginLoading());

    try {
      if (event.admin.email.isNotEmpty && event.admin.password.isNotEmpty) {
        final admindata = await firestore
            .collection('admin_register')
            .where('email', isEqualTo: event.admin.email)
            .where('password', isEqualTo: event.admin.password)
            .get();

        if (admindata.docs.isNotEmpty) {
          emit(AdminLoginSuccess(email: event.admin.email));
        } else {
          emit(AdminLoginFailure(error: 'Admin not registered'));
        }
      } else {
        emit(AdminLoginFailure(error: 'Incorrect username or password'));
      }
    } catch (error) {
      emit(AdminLoginFailure(error: error.toString()));
    }
  }
}
