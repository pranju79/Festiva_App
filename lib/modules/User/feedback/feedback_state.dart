import 'package:equatable/equatable.dart';

abstract class FeedbackState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FeedbackInitial extends FeedbackState {}

class FeedbackLoading extends FeedbackState {} // State while loading

class FeedbackSubmitted
    extends FeedbackState {} // State after successful submission

class FeedbackError extends FeedbackState {
  final String message;

  FeedbackError({required this.message});

  @override
  List<Object?> get props => [message];
}
