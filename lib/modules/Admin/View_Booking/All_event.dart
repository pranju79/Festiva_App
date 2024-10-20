import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_orientation_app/utils/components/tt_colors.dart';
import 'package:flutter/material.dart';

class EventDetailsPage extends StatefulWidget {
  final String eventName;
  final List<DocumentSnapshot> eventDetails;

  const EventDetailsPage({
    super.key,
    required this.eventName,
    required this.eventDetails,
  });

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  String? status;

  Future<void> _updateStatus(DocumentSnapshot doc, String newStatus) async {
    await FirebaseFirestore.instance
        .collection('Event Book')
        .doc(doc.id)
        .update({
      'status': newStatus,
    });
  }

  Future<void> _delete(DocumentSnapshot doc) async {
    await FirebaseFirestore.instance
        .collection('Event Book')
        .doc(doc.id)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    String eventName = args['eventName'];
    List<DocumentSnapshot> eventDetails = args['eventDetails'];
    return Scaffold(
      appBar: AppBar(
        foregroundColor: TTColors.white,
        title: Text('Details for $eventName'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple, Colors.pink],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.purple, Colors.pink],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: eventDetails.length,
          itemBuilder: (context, index) {
            final doc = eventDetails[index];
            final data = doc.data() as Map<String, dynamic>?;

            if (data == null) {
              return const Text("No data available");
            }

            String? currentStatus =
                data.containsKey('status') ? data['status'] : 'Confirm';

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name: ${data.containsKey('name') ? data['name'] : 'N/A'}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Email: ${data.containsKey('emailID') ? data['emailID'] : 'N/A'}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Mobile No: ${data.containsKey('mobileNo') ? data['mobileNo'] : 'N/A'}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Event Theme: ${data.containsKey('eventTheme') ? data['eventTheme'] : 'N/A'}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Location: ${data.containsKey('location') ? data['location'] : 'N/A'}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Date Of Event: ${data.containsKey('DOevent') ? data['DOevent'] : 'N/A'}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'No. of Guest: ${data.containsKey('noGuest') ? data['noGuest'] : 'N/A'}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: 300,
                      child: Column(
                        children: [
                          DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                              labelText: 'Status',
                              border: OutlineInputBorder(),
                            ),
                            value: currentStatus,
                            items: const [
                              DropdownMenuItem(
                                value: 'Pending',
                                child: Text('Pending'),
                              ),
                              DropdownMenuItem(
                                value: 'Confirm',
                                child: Text('Confirm'),
                              ),
                              DropdownMenuItem(
                                value: 'Cancel',
                                child: Text('Cancel'),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                status = value;
                                if (status != null) {
                                  _updateStatus(doc, status!);
                                }
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.delete),
                      label: const Text('Delete'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.red,
                      ),
                      onPressed: () {
                        _delete(doc);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
