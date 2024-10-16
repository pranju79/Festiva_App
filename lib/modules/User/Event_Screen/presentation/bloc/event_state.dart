import 'package:event_orientation_app/modules/Admin/Add_event/data/models/event_model.dart';

abstract class EventState {}

class EventLoading extends EventState {}

class EventLoaded extends EventState {
  final List<EventModel> events;

  EventLoaded(this.events);
}

class EventError extends EventState {
  final String message;

  EventError(this.message);
}
