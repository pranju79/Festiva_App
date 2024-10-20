import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_orientation_app/modules/User/feedback/feedback_event.dart';
import 'package:event_orientation_app/modules/User/feedback/feedback_state.dart';

class FeedbackBloc extends Bloc<FeedbackEvent, FeedbackState> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController eventController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController feedbackController = TextEditingController();

  FeedbackBloc() : super(FeedbackInitial()) {
    on<SubmitFeedback>((event, emit) async {
      emit(FeedbackLoading());
      try {
        await FirebaseFirestore.instance.collection('feedback').add({
          'name': event.name,
          'email': event.email,
          'event': event.event,
          'date': event.date,
          'feedback': event.feedback,
          'rating': event.rating,
        });
        emit(FeedbackSubmitted());
      } catch (e) {
        emit(FeedbackError(message: 'Failed to submit feedback: $e'));
      }
    });
  }

  @override
  Future<void> close() {
    nameController.dispose();
    eventController.dispose();
    dateController.dispose();
    feedbackController.dispose();
    return super.close();
  }
}
