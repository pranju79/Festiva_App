import 'package:event_orientation_app/modules/Admin/Add_event/data/models/event_model.dart';
import 'package:event_orientation_app/modules/User/Event_Screen/presentation/views/event_mobile_view.dart';
import 'package:event_orientation_app/utils/components/tt_colors.dart';
import 'package:event_orientation_app/utils/components/tt_typography.dart';
import 'package:event_orientation_app/utils/components/ui_helpers.dart';
import 'package:flutter/material.dart';

class EventListWidget extends StatelessWidget {
  final List<EventModel> events;
  String email;
  EventListWidget({super.key, required this.events,required this.email});

  final List<Map<String, String>> eventData = [
    {'image': 'assets/event4.jpg', },
    {'image':'assets/event5.jpg',},
    {'image': 'assets/event7.jpg', },
    {'image': 'assets/event6.jpg', },
    {'image':'assets/event2.jpg',},
    {'image':'assets/event3.jpg',},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        final eventimg = eventData[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EventMobileView(eventtype: event.eventtype,email:email)),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: 90,
                  height: 90,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: TTColors.gradientColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(eventimg['image']!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                UIHelpers.verticalSpaceTiny,
              
                Flexible(
                  child: Text(
                    event.eventtype, // Display event type here
                    style: TTypography.textBlack54Bold, // Adjust the style as needed
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
