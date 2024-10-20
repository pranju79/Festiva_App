import 'package:event_orientation_app/modules/Admin/Add_event/data/models/event_model.dart';
import 'package:event_orientation_app/modules/User/Event_Screen/presentation/views/event_mobile_view.dart';
import 'package:event_orientation_app/utils/components/tt_colors.dart';
import 'package:event_orientation_app/utils/components/tt_typography.dart';
import 'package:event_orientation_app/utils/components/ui_helpers.dart';
import 'package:flutter/material.dart';

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
      scrollDirection: Axis.horizontal,
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EventMobileView(
                      eventtype: event.eventtype, email: email)),
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
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(
                              'https://cdn-icons-png.flaticon.com/256/7425/7425048.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                UIHelpers.verticalSpaceSmall,
                Flexible(
                  child: Text(
                    event.eventtype,
                    style: TTypography.textBlack54Bold,
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
