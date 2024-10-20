import 'package:event_orientation_app/modules/User/EventList/presentation/widgets/event_card.dart';
import 'package:event_orientation_app/modules/User/Event_Screen/presentation/views/event_mobile_view.dart';
import 'package:flutter/material.dart';
import 'package:event_orientation_app/modules/Admin/Add_event/data/models/event_model.dart';

class EventListWidget extends StatelessWidget {
  final List<EventModel> events;
  final String email;
  const EventListWidget({
    super.key,
    required this.events,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EventMobileView(
                        eventtype: event.eventtype,
                        email: email,
                      )),
            );
          },
          child: EventCardWidget(
            event: event,
          ),
        );
      },
    );
  }
}
