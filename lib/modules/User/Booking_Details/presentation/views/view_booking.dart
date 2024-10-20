import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_orientation_app/modules/User/Booking_Details/presentation/widgets/view_booking_details.dart';
import 'package:event_orientation_app/modules/User/EventList/presentation/views/event_list_mobile_view.dart';
import 'package:event_orientation_app/utils/common/configuration_status_text.dart';
import 'package:event_orientation_app/utils/common/custom_button.dart';
import 'package:event_orientation_app/utils/components/tt_colors.dart';
import 'package:event_orientation_app/utils/components/tt_icons.dart';
import 'package:event_orientation_app/utils/components/tt_typography.dart';
import 'package:event_orientation_app/utils/components/ui_helpers.dart';
import 'package:flutter/material.dart';

class ViewBooking extends StatelessWidget {
  final String email;
  const ViewBooking({
    super.key,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: TTColors.white,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: TTColors.gradientColor,
          ),
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: TTColors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Booking Details'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Event Book')
            .where('emailID', isEqualTo: email)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  height: 400,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/event.png'),
                      UIHelpers.verticalSpaceSmall,
                      const Text(
                        'You have not made any bookings yet!',
                        style: TTypography.textBlack14,
                      ),
                      UIHelpers.verticalSpaceRegular,
                      GradientButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        EventListMobileView(email: email)));
                          },
                          child: const Padding(
                            padding: EdgeInsets.fromLTRB(40, 5, 40, 5),
                            child: Text(
                              'Book Your Event',
                              style: TTypography.textWhite16Bold,
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final doc = snapshot.data!.docs[index];
                final doEvent = doc['DOevent'];
                final eventName = doc['eventName'];
                final package = doc['package'];
                final status = doc['status'];

                return GestureDetector(
                  onTap: () {
                    final bookingId = doc.id;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ViewBookingDetails(
                                  Booking_id: bookingId,
                                )));
                  },
                  child: Card(
                    margin: const EdgeInsets.all(10),
                    child: SizedBox(
                      height: 130,
                      width: double.infinity,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Column(
                              children: [
                                ShaderMask(
                                  blendMode: BlendMode.srcIn,
                                  shaderCallback: (Rect bounds) {
                                    return const LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [TTColors.pink, TTColors.blue],
                                    ).createShader(bounds);
                                  },
                                  child: const Icon(TTIcons.event, size: 60),
                                ),
                                Text(
                                  doEvent,
                                  style: TTypography.textBlue12Bold,
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GradientText(
                                    eventName,
                                    gradient: TTColors.gradientColor,
                                    style: TTypography.textBlack18Bold,
                                  ),
                                  UIHelpers.verticalSpaceSmall,
                                  Text(
                                    'Package: \n$package',
                                    style: TTypography.textBlack14,
                                  ),
                                  UIHelpers.verticalSpaceSmall,
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: TTColors.whiteShade,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Text(
                                              '$status',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: getStatusTextColor(
                                                    '$status'),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
