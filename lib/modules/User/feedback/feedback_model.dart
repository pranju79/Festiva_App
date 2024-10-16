class FeedbackModel {
  final String name;
  final String email;
  final String event;
  final String date;
  final String feedback;
  final int rating; // Ensure this property exists

  FeedbackModel({
    required this.name,
    required this.email,
    required this.event,
    required this.date,
    required this.feedback,
    required this.rating,
  });

  factory FeedbackModel.fromFirestore(Map<String, dynamic> data) {
    return FeedbackModel(
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      event: data['event'] ?? '',
      date: data['date'] ?? '',
      feedback: data['feedback'] ?? '',
      rating: data['rating'] ?? 0, // Make sure this matches your Firestore schema
    );
  }
}
