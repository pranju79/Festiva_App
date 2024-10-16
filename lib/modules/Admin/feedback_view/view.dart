import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:event_orientation_app/modules/User/feedback/feedback_model.dart';
import 'package:event_orientation_app/utils/components/tt_colors.dart';
import 'package:event_orientation_app/utils/components/tt_typography.dart';

class FeedbackListPage extends StatefulWidget {
  const FeedbackListPage({super.key});

  @override
  State<FeedbackListPage> createState() => _FeedbackListPageState();
}

class _FeedbackListPageState extends State<FeedbackListPage> {
  final List<Color> gradientColors = [
    TTColors.blue,
    TTColors.purple,
    TTColors.pink,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: TTColors.white,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text('User Feedbacks'),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: TTColors.gradientColor),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('feedback').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(
                  child: Text('No feedback available.',
                      style: TTypography.textBlue30Bold));
            }

            final feedbacks = snapshot.data!.docs
                .map((doc) => FeedbackModel.fromFirestore(
                    doc.data() as Map<String, dynamic>))
                .toList();

            return ListView.builder(
              itemCount: feedbacks.length,
              itemBuilder: (context, index) {
                final feedback = feedbacks[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.person, color: TTColors.blue),
                            const SizedBox(width: 8),
                            Text("Name: ${feedback.name}",
                                style: TTypography.textBlack16),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.email, color: TTColors.blue),
                            const SizedBox(width: 8),
                            Text("Email: ${feedback.email}",
                                style: TTypography.textBlack16),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.event, color: TTColors.blue),
                            const SizedBox(width: 8),
                            Text("Event: ${feedback.event}",
                                style: TTypography.textBlack16),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.date_range, color: TTColors.blue),
                            const SizedBox(width: 8),
                            Text("Date: ${feedback.date}",
                                style: TTypography.textBlack16),
                          ],
                        ),
                        const SizedBox(height: 10),
                        // Display user rating as stars
                        RatingBarIndicator(
                          rating: feedback.rating
                              .toDouble(), // Use actual user rating
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 25.0,
                          direction: Axis.horizontal,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
