import 'package:event_orientation_app/modules/Admin/Add_event/data/models/event_model.dart';
import 'package:event_orientation_app/modules/User/Event_Screen/presentation/views/event_mobile_view.dart';
import 'package:event_orientation_app/utils/components/tt_colors.dart';
import 'package:event_orientation_app/utils/components/tt_typography.dart';
import 'package:flutter/material.dart';

class UpcomingEventsWidget extends StatelessWidget {
  final List<EventModel> events;
  final String email;

  UpcomingEventsWidget({
    super.key,
    required this.events,
    required this.email,
  });

  List<Map<String, String>> _filterUpcomingEvents() {
    final currentDate = DateTime.now();

    final filteredEvents = upcomingEvents.where((event) {
      final eventDate = DateTime.parse(event['date']!);
      return eventDate.isAfter(currentDate) ||
          eventDate.isAtSameMomentAs(currentDate);
    }).toList();
    return filteredEvents;
  }

  final List<Map<String, String>> upcomingEvents = [
    {
      'image':
          'https://media.istockphoto.com/id/1289085646/vector/holiday-abstract-shiny-color-gold-design-element.jpg?s=612x612&w=0&k=20&c=KxxPq3pjtgny0SHSF8BLyX1RnxHRa3KmW1fVFn9L2xc=',
      'date': '2024-12-15'
    },
    {
      'image':
          'https://media.istockphoto.com/id/1289085646/vector/holiday-abstract-shiny-color-gold-design-element.jpg?s=612x612&w=0&k=20&c=KxxPq3pjtgny0SHSF8BLyX1RnxHRa3KmW1fVFn9L2xc=',
      'date': '2024-11-26'
    },
    {
      'image':
          'https://media.istockphoto.com/id/1289085646/vector/holiday-abstract-shiny-color-gold-design-element.jpg?s=612x612&w=0&k=20&c=KxxPq3pjtgny0SHSF8BLyX1RnxHRa3KmW1fVFn9L2xc=',
      'date': '2024-10-10'
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredEvents = _filterUpcomingEvents();

    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: filteredEvents.length,
      itemBuilder: (context, index) {
        final event = events[index];
        final eventDetails = filteredEvents[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EventMobileView(
                  eventtype: event.eventtype,
                  email: email,
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Stack(
              children: [
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    gradient: TTColors.gradientColor,
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      width: 2.0,
                      color: TTColors.transparent,
                    ),
                  ),
                  padding: const EdgeInsets.all(2.0),
                ),
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: TTColors.white,
                    borderRadius: BorderRadius.circular(20.0),
                    image: DecorationImage(
                      image: NetworkImage(eventDetails['image']!),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 0.95,
                      height: 150,
                      decoration: BoxDecoration(
                        color: TTColors.blackOpacity,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            event.eventtype,
                            style: TTypography.textWhite20Bold,
                          ),
                          Text(
                            eventDetails['date']!,
                            style: TTypography.textWhite18,
                          ),
                        ],
                      ),
                    ),
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
