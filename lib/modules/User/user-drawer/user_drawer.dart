import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_orientation_app/modules/User/Booking_Details/presentation/views/view_booking.dart';
import 'package:event_orientation_app/modules/User/EventList/presentation/views/event_list_mobile_view.dart';
import 'package:event_orientation_app/modules/User/feedback/uiview/feedback_form_screen.dart';
import 'package:event_orientation_app/utils/components/tt_colors.dart';
import 'package:event_orientation_app/utils/components/tt_icons.dart';
import 'package:flutter/material.dart';

class UserDrawer extends StatelessWidget {
  String? email;

  UserDrawer({
    super.key,
    required this.email,
  });

  Future<Map<String, dynamic>?> getUserDetails(String email) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('UserRegister')
        .where('Email', isEqualTo: email)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs.first.data();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            color: TTColors.white.withOpacity(0.7),
          ),
        ),
        FutureBuilder<Map<String, dynamic>?>(
          future: getUserDetails(email!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error loading user details'));
            } else if (!snapshot.hasData || snapshot.data == null) {
              return const Center(child: Text('User not found'));
            } else {
              final userData = snapshot.data!;
              final userName = userData['Name'] ?? 'User';
              final userEmail = userData['Email'] ?? 'user@gmail.com';

              return Container(
                color: Colors.transparent,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    UserAccountsDrawerHeader(
                      accountName: Text(
                        userName,
                        style: const TextStyle(color: TTColors.white),
                      ),
                      accountEmail: Text(
                        userEmail,
                        style: const TextStyle(color: TTColors.white),
                      ),
                      currentAccountPicture: const CircleAvatar(
                        backgroundImage: AssetImage('assets/image.png'),
                      ),
                      decoration: const BoxDecoration(
                        gradient: TTColors.gradientColor,
                      ),
                    ),
                    ListTile(
                      leading: const Icon(
                        TTIcons.dashboard,
                        color: TTColors.darkBlue,
                      ),
                      title: const Text(
                        'Dashboard',
                        style: TextStyle(color: TTColors.darkBlue),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        TTIcons.event,
                        color: TTColors.darkBlue,
                      ),
                      title: const Text(
                        'Event List',
                        style: TextStyle(color: TTColors.darkBlue),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    EventListMobileView(email: userEmail)));
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        TTIcons.details,
                        color: TTColors.darkBlue,
                      ),
                      title: const Text(
                        'Booking Details',
                        style: TextStyle(color: TTColors.darkBlue),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ViewBooking(email: userEmail)));
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        TTIcons.feedback,
                        color: TTColors.darkBlue,
                      ),
                      title: const Text(
                        'Feedback',
                        style: TextStyle(color: TTColors.darkBlue),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => FeedbackPage(email: userEmail)));
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        TTIcons.contactMail,
                        color: TTColors.darkBlue,
                      ),
                      title: const Text(
                        'Contact Us',
                        style: TextStyle(color: TTColors.darkBlue),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/ownerdetails');
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        TTIcons.dataUsage,
                        color: TTColors.darkBlue,
                      ),
                      title: const Text(
                        'Terms and Policies',
                        style: TextStyle(color: TTColors.darkBlue),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/termspolicies');
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        TTIcons.logout,
                        color: TTColors.darkBlue,
                      ),
                      title: const Text(
                        'Logout',
                        style: TextStyle(color: TTColors.darkBlue),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/login');
                      },
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ]),
    );
  }
}
