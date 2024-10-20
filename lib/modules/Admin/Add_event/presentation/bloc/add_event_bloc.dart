import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_orientation_app/modules/Admin/Add_event/presentation/bloc/add_event_event.dart';
import 'package:event_orientation_app/modules/Admin/Add_event/presentation/bloc/add_event_state.dart';
import 'package:flutter/material.dart';

class AddEventBloc extends Bloc<AddEventEvent, AddEventState> {
  //EventForm Controllers
  final TextEditingController eventtitleController = TextEditingController();
  final TextEditingController imageurlController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController serviceController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController packageController = TextEditingController();
  final TextEditingController eventDateController = TextEditingController();
  //ThemeForm Controllers
  final TextEditingController themetitleController = TextEditingController();
  final TextEditingController themeimageController = TextEditingController();
  final TextEditingController themedescriptionController =
      TextEditingController();
  final TextEditingController themedecorationController =
      TextEditingController();
  final TextEditingController themeactivitiesController =
      TextEditingController();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  AddEventBloc() : super(AddEventInitialState()) {
    on<AddEventEvent>((event, emit) {});

    on<OnAddEvent>(onSubmitAddEvent);

    on<OnAddTheme>(onSubmitAddTheme);
  }

  FutureOr<void> onSubmitAddEvent(
      OnAddEvent event, Emitter<AddEventState> emit) async {
    emit(AddEventLoadingState());
    if (event.eventInfo.title.isEmpty ||
        event.eventInfo.imageUrl.isEmpty ||
        event.eventInfo.description.isEmpty ||
        event.eventInfo.service.isEmpty ||
        event.eventInfo.price.isEmpty ||
        event.eventInfo.package.isEmpty ||
        event.eventInfo.theme.isEmpty) {
      emit(AddEventErrorState(error: 'All Fields are required!'));
    }
    try {
      await firestore.collection('event collection').add({
        'event title': event.eventInfo.title,
        'imageurl': event.eventInfo.imageUrl,
        'description': event.eventInfo.description,
        'service': event.eventInfo.service,
        'package': event.eventInfo.package,
        'price': event.eventInfo.price,
        'theme_type': event.eventInfo.theme,
        'event_type': event.eventInfo.eventtype,
        'event_date': event.eventInfo.event_date,
      });
      emit(AddEventSucessState());
    } catch (error) {
      emit(AddEventFailureState(message: 'Error Occured!'));
    }
  }

  FutureOr<void> onSubmitAddTheme(
      OnAddTheme event, Emitter<AddEventState> emit) async {
    emit(AddEventLoadingState());
    if (event.themeInfo.theme.isEmpty ||
        event.themeInfo.themetitle.isEmpty ||
        event.themeInfo.themeimage.isEmpty ||
        event.themeInfo.themedescription.isEmpty ||
        event.themeInfo.themedecoration.isEmpty ||
        event.themeInfo.themeactivities.isEmpty) {
      emit(AddEventErrorState(error: 'All Fields are required!'));
    }
    try {
      await firestore.collection('theme collection').add({
        'theme_type': event.themeInfo.theme,
        'theme_title': event.themeInfo.themetitle,
        'theme_image': event.themeInfo.themeimage,
        'theme_description': event.themeInfo.themedescription,
        'theme_decoration': event.themeInfo.themedecoration,
        'theme_activites': event.themeInfo.themeactivities,
      });
      emit(AddEventSucessState());
    } catch (error) {
      emit(AddEventFailureState(message: 'Error Occured!'));
    }
  }
}
