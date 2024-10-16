import 'dart:async';

//import 'package:bloc/bloc.dart';
// import 'package:event_orientation_app/modules/UserRegister_Screen/data/models/user_model.dart';
// import 'package:event_orientation_app/modules/UserRegister_Screen/data/models/user_model.dart';
import 'package:event_orientation_app/modules/User/UserRegister_Screen/presentation/bloc/login/login_event.dart';
import 'package:event_orientation_app/modules/User/UserRegister_Screen/presentation/bloc/login/login_state.dart';
// import 'package:event_orientation_app/modules/UserRegister_Screen/presentation/bloc/user_register_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


//part 'user_register_event.dart';
//part 'user_register_state.dart';
class LoginBloc extends Bloc<LoginEvent, LoginState>{
  final TextEditingController passController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance; 

  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {});

    on<LoginButtonPressed>(onlogin);
  }

  FutureOr<void>onlogin(LoginButtonPressed event, Emitter<LoginState> emit) async {
    emit(LoginLoading());

    try {
      if (event.users.email.isNotEmpty && event.users.password.isNotEmpty) {
        final userdata = await firestore.collection('UserRegister')
            .where('Email', isEqualTo: event.users.email)
            .where('Password', isEqualTo: event.users.password)
            .get();

        if (userdata.docs.isNotEmpty) {
          emit(LoginSuccess(email: event.users.email));
        } else {
          emit(LoginFailure(error: 'User not registered'));
        }
      } else {
        emit(LoginFailure(error: 'Incorrect username or password'));
      }
    } catch (error) {
      emit(LoginFailure(error: error.toString()));
    }
  }
}

