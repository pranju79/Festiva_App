part of 'eventbook_bloc.dart';

abstract class EventbookEvent {}

final class OnSubmitEvent extends EventbookEvent{
final Eventbook book;
OnSubmitEvent({required this.book});

}



