import 'package:equatable/equatable.dart';

abstract class FeedbackEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SubmitFeedback extends FeedbackEvent {
  final String name;
  final String email;
  final String event;
  final String date;
  final String feedback;
  final int rating;

  SubmitFeedback({
    required this.name,
    required this.email,
    required this.event,
    required this.date,
    required this.feedback,
    required this.rating,
  });

  @override
  List<Object?> get props => [name, email, event, date, feedback, rating];
}
