import 'package:event_orientation_app/modules/Admin/admin_drawer/admin_drawer.dart';
import 'package:event_orientation_app/utils/components/tt_icons.dart';
import 'package:event_orientation_app/utils/components/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_orientation_app/utils/components/tt_colors.dart';
import 'package:carousel_slider/carousel_slider.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  int totalUsers = 0;
  int totalEvents = 0;
  int totalBookings = 0;
  double totalRevenue = 0.0;

  @override
  void initState() {
    super.initState();
    _fetchCounts();
  }

  Future<void> _fetchCounts() async {
    final userSnapshot =
        await FirebaseFirestore.instance.collection('UserRegister').get();
    final eventSnapshot =
        await FirebaseFirestore.instance.collection('Event Book').get();
    final bookingSnapshot =
        await FirebaseFirestore.instance.collection('Event Book').get();
    final revenueSnapshot =
        await FirebaseFirestore.instance.collection('event').get();

    setState(() {
      totalUsers = userSnapshot.size;
      totalEvents = eventSnapshot.size;
      totalBookings = bookingSnapshot.size;
      totalRevenue = revenueSnapshot.docs
          .fold(0.0, (sum, doc) => sum + (doc['revenue'] ?? 0.0));
    });
  }

  @override
  Widget build(BuildContext context) {
    final String email = ModalRoute.of(context)?.settings.arguments as String;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        foregroundColor: TTColors.white,
        title: const Text(
          'Welcome Admin',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/adminprofile',
                arguments: email,
              );
            },
            icon: const Icon(
              TTIcons.profileRounded,
              color: TTColors.white,
            ),
          ),
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: TTColors.gradientColor,
          ),
        ),
      ),
      drawer: AdminDrawer(email: email),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: screenHeight * 0.30,
                  autoPlay: true,
                  enlargeCenterPage: true,
                ),
                items: [
                  'assets/event1.jpg',
                  'assets/event2.jpg',
                  'assets/event3.jpg',
                ].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: screenWidth,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            i,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                height: screenHeight * 0.22,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildInfoCard('Total Users', '$totalUsers', Icons.people,
                        screenWidth),
                    _buildInfoCard('Total Events', '$totalEvents', Icons.event,
                        screenWidth),
                    _buildInfoCard('Total Bookings', '$totalBookings',
                        Icons.book_online, screenWidth),
                    _buildInfoCard('Total Revenue', '\$$totalRevenue',
                        Icons.attach_money, screenWidth),
                  ],
                ),
              ),
              UIHelpers.verticalSpaceMedium,
              const Center(
                child: Text(
                  'Recent Users',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: TTColors.primary,
                  ),
                ),
              ),
              UIHelpers.verticalSpaceRegular,
              SizedBox(
                height: screenHeight * 0.3,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('UserRegister')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final data = snapshot.requireData;
                    return ListView.builder(
                      itemCount: data.size,
                      itemBuilder: (context, index) {
                        final employeeData =
                            data.docs[index].data() as Map<String, dynamic>;
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            leading: const Icon(Icons.person,
                                color: TTColors.primary),
                            title: Text(employeeData['Name'] ?? 'N/A',
                                style: const TextStyle(
                                    color: TTColors.textPrimary)),
                            subtitle: Text(employeeData['Email'] ?? 'N/A',
                                style: const TextStyle(
                                    color: TTColors.textSecondary)),
                            trailing: Text(employeeData['MobileNo'] ?? 'N/A',
                                style: const TextStyle(
                                    color: TTColors.textSecondary)),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              UIHelpers.verticalSpaceMedium,
              const Center(
                child: Text(
                  'Booked Events',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: TTColors.primary,
                  ),
                ),
              ),
              UIHelpers.verticalSpaceRegular,
              SizedBox(
                height: screenHeight * 0.3,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Event Book')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final data = snapshot.requireData;
                    return ListView.builder(
                      itemCount: data.size,
                      itemBuilder: (context, index) {
                        final eventData =
                            data.docs[index].data() as Map<String, dynamic>;
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            leading: const Icon(Icons.event,
                                color: TTColors.primary),
                            title: Text(eventData['eventName'] ?? 'N/A',
                                style: const TextStyle(
                                    color: TTColors.textPrimary)),
                            subtitle: Text(eventData['DOevent'] ?? 'N/A',
                                style: const TextStyle(
                                    color: TTColors.textSecondary)),
                            trailing: Text(eventData['location'] ?? 'N/A',
                                style: const TextStyle(
                                    color: TTColors.textSecondary)),
                            onTap: () => _showEventDetails(context, eventData),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showEventDetails(BuildContext context, Map<String, dynamic> eventData) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(eventData['eventName'] ?? 'N/A'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Date: ${eventData['DOevent'] ?? 'N/A'}'),
                Text('Email: ${eventData['emailID'] ?? 'N/A'}'),
                Text('Theme: ${eventData['eventTheme'] ?? 'N/A'}'),
                Text('Location: ${eventData['location'] ?? 'N/A'}'),
                Text('Mobile No: ${eventData['mobileNo'] ?? 'N/A'}'),
                Text('Name: ${eventData['name'] ?? 'N/A'}'),
                Text('No. of Guests: ${eventData['noGuest'] ?? 'N/A'}'),
                Text('Package: ${eventData['package'] ?? 'N/A'}'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildInfoCard(
      String title, String count, IconData icon, double screenWidth) {
    return Container(
      width: screenWidth * 0.4,
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(
          color: TTColors.primary,
          width: 1.0,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: TTColors.primary, size: 32.0),
          const SizedBox(height: 8.0),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: TTColors.textPrimary),
          ),
          const SizedBox(height: 8.0),
          Text(
            count,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: TTColors.textPrimary),
          ),
        ],
      ),
    );
  }
}
