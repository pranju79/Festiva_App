// ignore_for_file: must_be_immutable

part of 'eventbook_bloc.dart';

@immutable
sealed class EventbookState {}

final class EventbookInitial extends EventbookState {}

final class EventbookSuccess extends EventbookState{}
final class EventbookLoadiing extends EventbookState{}
final class EventbookError extends EventbookState{
String error;
EventbookError({required this.error});
}
final class EventbookFailure extends EventbookState{
String message;
EventbookFailure({required this.message});
}