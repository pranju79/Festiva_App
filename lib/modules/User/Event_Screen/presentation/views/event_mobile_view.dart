import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_orientation_app/modules/User/Event_Screen/presentation/widgets/event_details_view.dart';
import 'package:event_orientation_app/utils/components/tt_colors.dart';
import 'package:event_orientation_app/utils/components/tt_typography.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EventMobileView extends StatelessWidget {
  String eventtype;
  final String email;
  EventMobileView({super.key,required this.eventtype,required this.email});

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
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
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
                                  event_id: event_id,email: email,
                                )));
                  },
                  child: Card(
                    shadowColor: TTColors.black.withOpacity(0.5),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.network(
                            (doc['imageurl']),
                            fit: BoxFit.cover,
                            width: 100,
                            height: 100,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 100,
                                height: 100,
                                decoration: const BoxDecoration(gradient:  LinearGradient(colors: [TTColors.pink, TTColors.blue],)),
                                child: const Icon(Icons.celebration_rounded,
                                    color: Colors.white, size: 50),
                              );
                            },
                          ),
                        ),
                        Text('${doc["event title"]}',
                            style: TTypography.textBlack14Bold),
                      ],
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}
