part of 'eventbook_bloc.dart';

@immutable
sealed class EventbookState {}

final class EventbookInitial extends EventbookState {}

final class EventbookSuccess extends EventbookState {}

final class EventbookLoadiing extends EventbookState {}

final class EventbookError extends EventbookState {
  final String error;
  EventbookError({required this.error});
}

final class EventbookFailure extends EventbookState {
  final String message;
  EventbookFailure({required this.message});
}
