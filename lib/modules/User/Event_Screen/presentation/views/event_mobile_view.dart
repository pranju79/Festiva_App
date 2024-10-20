import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_orientation_app/modules/User/Event_Screen/presentation/widgets/event_details_view.dart';
import 'package:event_orientation_app/utils/components/tt_colors.dart';
import 'package:event_orientation_app/utils/components/tt_typography.dart';
import 'package:event_orientation_app/utils/components/ui_helpers.dart';
import 'package:flutter/material.dart';

class EventMobileView extends StatelessWidget {
  final String eventtype;
  final String email;
  const EventMobileView({
    super.key,
    required this.eventtype,
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
        title: Text(eventtype ?? ''),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('event collection')
              .where('event_type', isEqualTo: eventtype)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final doc = snapshot.data!.docs[index];
                  return GestureDetector(
                    onTap: () {
                      final event_id = doc.id;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => EventDetailsView(
                                    event_id: event_id,
                                    email: email,
                                  )));
                    },
                    child: Card(
                      elevation: 10,
                      shadowColor: TTColors.black.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: TTColors.black.withOpacity(0.2),
                                    blurRadius: 8,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  (doc['imageurl']),
                                  fit: BoxFit.cover,
                                  width: 100,
                                  height: 100,
                                  loadingBuilder: (context, child, progress) {
                                    return progress == null
                                        ? child
                                        : Container(
                                            width: 100,
                                            height: 100,
                                            alignment: Alignment.center,
                                            decoration: const BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  TTColors.pink,
                                                  TTColors.blue
                                                ],
                                              ),
                                            ),
                                            child: CircularProgressIndicator(
                                              value: progress
                                                      .cumulativeBytesLoaded /
                                                  (progress
                                                          .expectedTotalBytes ??
                                                      1),
                                              valueColor:
                                                  const AlwaysStoppedAnimation<
                                                      Color>(TTColors.white),
                                            ),
                                          );
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      width: 100,
                                      height: 100,
                                      decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            TTColors.pink,
                                            TTColors.blue
                                          ],
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                      ),
                                      child: const Icon(
                                          Icons.celebration_rounded,
                                          color: Colors.white,
                                          size: 50),
                                    );
                                  },
                                ),
                              ),
                            ),
                            UIHelpers.verticalSpaceMedium,
                            Text(
                              '${doc["event title"]}',
                              style: TTypography.textBlack14Bold.copyWith(
                                color: TTColors.black,
                                letterSpacing: 1.2,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }),
    );
  }
}
