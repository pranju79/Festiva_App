import 'dart:async';
//import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_orientation_app/modules/User/EventBookForm/data/models/eventbook_model.dart';
//import 'package:event_orientation_app/modules/EventBookForm/data/models/eventbook_model.dart';

import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'eventbook_event.dart';
part 'eventbook_state.dart';

class EventbookBloc extends Bloc<EventbookEvent, EventbookState> {

final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController dateofeventController = TextEditingController();
    final TextEditingController guestController = TextEditingController();
      final TextEditingController locationController = TextEditingController();
      
  final FirebaseFirestore firestore = FirebaseFirestore.instance; 


  EventbookBloc() : super(EventbookInitial()) {
    on<EventbookEvent>((event, emit) {});
   on<OnSubmitEvent>(onSubmit);
    }
    
     FutureOr<void> onSubmit(OnSubmitEvent event, Emitter<EventbookState> emit)async{
    emit(EventbookLoadiing());
  
    try{
           await firestore.collection('Event Book').add({
            'name': event.book.name,
            'emailID': event.book.email,
            'mobileNo':event.book.mobile,
            'eventName':event.book.eventname,
            'eventTheme' :event.book.eventTheme,
            'DOevent': event.book.dateofevent,
            'location':event.book.location,
            'package':event.book.packages,
            'noGuest': event.book.guest,
            'status': event.book.status,
           });
          //await firestore.collection('UserRegister').add(event.user.toMap());
          emit(EventbookSuccess());
    }
    catch (error){
      emit(EventbookFailure(message: 'Something Went wrong!'));
    }
     }
  }


