import 'package:event_orientation_app/modules/User/EventList/presentation/widgets/event_card.dart';
import 'package:event_orientation_app/modules/User/Event_Screen/presentation/views/event_mobile_view.dart';
import 'package:flutter/material.dart';
import 'package:event_orientation_app/modules/Admin/Add_event/data/models/event_model.dart';

class EventListWidget extends StatelessWidget {
  final List<EventModel> events;
   String email;
  EventListWidget({super.key, required this.events,required this.email});

  final List<Map<String, String>> eventData = [
    {'image': 'https://i.pinimg.com/564x/a8/57/0e/a8570e096c7fb4f716f0950b8d3eacc1.jpg'},
    {'image': 'https://i.pinimg.com/564x/08/ea/dc/08eadce4a60ffe267caf88e0c8724b64.jpg'},
    {'image': 'https://i.pinimg.com/564x/18/ad/2d/18ad2d97321660b981729071498ddbb9.jpg'},
    {'image': 'https://i.pinimg.com/564x/42/77/16/427716a469a665376f0fc9bad0064303.jpg'},
    {'image': 'https://i.pinimg.com/736x/8c/1f/9b/8c1f9b715530243ab05daeb3c6c142f1.jpg'},
    {'image': 'https://i.pinimg.com/564x/10/b4/6a/10b46aeea537f4c66bc9d5b605a60822.jpg'},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        final eventimg = eventData[index % eventData.length]; 
        return GestureDetector(
         onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EventMobileView(eventtype: event.eventtype,email: email,)),
            );
          },
          child: EventCardWidget(
            event: event,
            imageUrl: eventimg['image']!,
          ),
        );
      },
    );
  }
}
