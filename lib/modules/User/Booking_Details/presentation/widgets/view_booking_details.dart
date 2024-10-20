import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_orientation_app/utils/common/configuration_status_text.dart';
import 'package:event_orientation_app/utils/components/tt_colors.dart';
import 'package:event_orientation_app/utils/components/tt_typography.dart';
import 'package:event_orientation_app/utils/components/ui_helpers.dart';
import 'package:flutter/material.dart';

class ViewBookingDetails extends StatefulWidget {
  final String? Booking_id;
  const ViewBookingDetails({
    super.key,
    this.Booking_id,
  });

  @override
  State<ViewBookingDetails> createState() => _ViewBookingDetailsState();
}

class _ViewBookingDetailsState extends State<ViewBookingDetails> {
  @override
  Widget build(BuildContext context) {
    bool isVisible = true;
    String status = 'Confirm';
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
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection('Event Book').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(child: Text('Error loading data.'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            var doc;
            try {
              doc = snapshot.data!.docs
                  .firstWhere((doc) => doc.id == widget.Booking_id);
            } catch (e) {
              return const Center(child: Text('Data not found.'));
            }

            if (status == '${doc['status']}') {
              isVisible = false;
            }

            return Container(
              margin: const EdgeInsets.all(20),
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: TTColors.gradientColor,
              ),
              child: Container(
                margin: const EdgeInsets.all(5),
                color: TTColors.white,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Event Name:  ',
                            style: TTypography.textBlack16Bold,
                          ),
                          GradientText(
                            '${doc['eventName']}',
                            gradient: TTColors.gradientColor,
                            style: TTypography.textBlack16Bold,
                          ),
                        ],
                      ),
                      UIHelpers.verticalSpaceRegular,
                      Row(
                        children: [
                          const Text(
                            'Theme Type: ',
                            style: TTypography.textBlack16Bold,
                          ),
                          Text(
                            '${doc['eventTheme']}',
                            style: TTypography.textBlack16,
                          ),
                        ],
                      ),
                      UIHelpers.verticalSpaceRegular,
                      Row(
                        children: [
                          const Text(
                            'Date Of Event: ',
                            style: TTypography.textBlack16Bold,
                          ),
                          Text(
                            '${doc['DOevent']}',
                            style: TTypography.textBlack16,
                          ),
                        ],
                      ),
                      UIHelpers.verticalSpaceRegular,
                      Row(
                        children: [
                          const Text(
                            'Location:  ',
                            style: TTypography.textBlack16Bold,
                          ),
                          Text(
                            '${doc['location']}',
                            style: TTypography.textBlack16,
                          ),
                        ],
                      ),
                      UIHelpers.verticalSpaceRegular,
                      Row(
                        children: [
                          const Text(
                            'No.Of Guest:  ',
                            style: TTypography.textBlack16Bold,
                          ),
                          Text(
                            '${doc['noGuest']}',
                            style: TTypography.textBlack16,
                          ),
                        ],
                      ),
                      UIHelpers.verticalSpaceRegular,
                      Row(
                        children: [
                          const Text(
                            'Package: ',
                            style: TTypography.textBlack16Bold,
                          ),
                          Text(
                            '${doc['package']}',
                            style: TTypography.textBlack14,
                          ),
                        ],
                      ),
                      UIHelpers.verticalSpaceRegular,
                      Row(
                        children: [
                          const Text(
                            'Status:  ',
                            style: TTypography.textBlack16Bold,
                          ),
                          Text(
                            '${doc['status']}',
                            style: TextStyle(
                                color: getStatusTextColor('${doc['status']}'),
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      UIHelpers.verticalSpaceLargePlus,
                      Visibility(
                        visible: isVisible,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 239, 243, 145),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.warning_amber_rounded,
                                      size: 20,
                                      color: TTColors.danger,
                                    ),
                                    Text(
                                      'For Confirm Your Booking Please Contact Owner',
                                      maxLines: 2,
                                      style: TextStyle(fontSize: 10),
                                    )
                                  ],
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, '/ownerdetails');
                                    },
                                    child: const Text(
                                      'Contact Us',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: TTColors.blue,
                                          decoration: TextDecoration.underline,
                                          decorationColor: TTColors.blue),
                                    ))
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
