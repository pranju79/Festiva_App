import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_orientation_app/modules/User/Event_Screen/presentation/widgets/theme_view.dart';
import 'package:event_orientation_app/utils/common/custom_button.dart';
import 'package:event_orientation_app/utils/components/tt_colors.dart';
import 'package:event_orientation_app/utils/components/tt_typography.dart';
import 'package:event_orientation_app/utils/components/ui_helpers.dart';
import 'package:flutter/material.dart';

class EventDetailsView extends StatelessWidget {
  final String? event_id;
  final String email;
  const EventDetailsView(
      {super.key, required this.event_id, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: TTColors.gradientColor,
          ),
        ),
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.arrow_back, color: TTColors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('event collection')
              .snapshots(),
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
              doc = snapshot.data!.docs.firstWhere((doc) => doc.id == event_id);
            } catch (e) {
              return const Center(child: Text('Event not found.'));
            }

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        '${doc['event title']}',
                        style: TTypography.textBlack30,
                      ),
                    ),
                    UIHelpers.verticalSpaceSmall,
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        'https://st.depositphotos.com/1020288/4070/i/450/depositphotos_40707529-stock-photo-cheerful-group-of-young-people.jpg',
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
                    ),
                    UIHelpers.verticalSpaceSmall,
                    Text(
                      '${doc['description']}',
                      style: TTypography.textBlack18,
                    ),
                    UIHelpers.verticalSpaceRegular,
                    const Text(
                      'Services:',
                      style: TTypography.textBlack22Bold,
                    ),
                    UIHelpers.verticalSpaceRegular,
                    Text(
                      '${doc['service']}',
                      style: TTypography.textBlack18,
                    ),
                    UIHelpers.verticalSpaceRegular,
                    Row(
                      children: [
                        const Text(
                          'Price: ',
                          style: TTypography.textBlack22Bold,
                        ),
                        Text(
                          '${doc['price']}',
                          style: TTypography.textBlack20,
                        )
                      ],
                    ),
                    UIHelpers.verticalSpaceMedium,
                    GradientButton(
                        onPressed: () {
                          String theme_type = doc['theme_type'];
                          String eventname = doc['event title'];
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => ThemeView(
                                    eventname: eventname,
                                    theme_type: theme_type,
                                    email: email,
                                  )));
                        },
                        child: const Text(
                          'Themes',
                          style: TTypography.textWhite20Bold,
                        ))
                  ],
                ),
              ),
            );
          }),
    );
  }
}
