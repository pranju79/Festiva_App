import 'package:event_orientation_app/modules/Admin/Add_event/data/models/event_model.dart';
import 'package:event_orientation_app/modules/User/Event_Screen/presentation/bloc/event_event.dart';
import 'package:event_orientation_app/modules/User/Event_Screen/presentation/bloc/event_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';


class EventBloc extends Bloc<EventEvent, EventState> {
  EventBloc() : super(EventLoading()) {
    on<FetchEvents>(_onFetchEvents);
  }

  Future<void> _onFetchEvents(FetchEvents event, Emitter<EventState> emit) async {
    emit(EventLoading());
    try {
      final events = await _fetchEvents();
      emit(EventLoaded(events));
      _saveEventsToLocal(events); 
    } catch (e) {
      emit(EventError("Failed to fetch events."));
    }
  }

  Future<List<EventModel>> _fetchEvents() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('event collection').get();
    return snapshot.docs.map((doc) => EventModel.fromFirestore(doc.data() as Map<String, dynamic>)).toList();
  }

  Future<void> _saveEventsToLocal(List<EventModel> events) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> eventStrings = events.map((event) {
      return "${event.imageUrl}|${event.title}|${event.eventtype}";
    }).toList();
    await prefs.setStringList('saved_events', eventStrings);
  }

  Future<List<EventModel>> _loadEventsFromLocal() async {
    final prefs = await SharedPreferences.getInstance();
    final eventStrings = prefs.getStringList('saved_events') ?? [];
    return eventStrings.map((eventString) {
      final parts = eventString.split('|');
      return EventModel(
        imageUrl: parts[0],
        title: parts[1],
        eventtype: parts[2],
        description: '',
        service: '',
        price: '',
        package: '',
        theme: '', 
        event_date: '',
      );
    }).toList();
  }
}
