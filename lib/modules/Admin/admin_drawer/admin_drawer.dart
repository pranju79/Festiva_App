import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_orientation_app/utils/components/tt_colors.dart';
import 'package:flutter/material.dart';

class AdminDrawer extends StatelessWidget {
  final String email;

  const AdminDrawer({
    super.key,
    required this.email,
  });

  Future<Map<String, dynamic>?> getAdminDetails(String email) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('admin_register')
        .where('email', isEqualTo: email)
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
      child: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              color: TTColors.white.withOpacity(0.7),
            ),
          ),
          FutureBuilder<Map<String, dynamic>?>(
            future: getAdminDetails(email),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text('Error loading admin details'));
              } else if (!snapshot.hasData || snapshot.data == null) {
                return const Center(child: Text('Admin not found'));
              } else {
                final adminData = snapshot.data!;
                final adminName = adminData['name'] ?? 'Admin';
                final adminEmail = adminData['email'] ?? 'admin@gmail.com';

                return Container(
                  color: Colors.transparent,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                      UserAccountsDrawerHeader(
                        accountName: Text(
                          adminName,
                          style: const TextStyle(color: TTColors.white),
                        ),
                        accountEmail: Text(
                          adminEmail,
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
                        leading: const Icon(Icons.dashboard,
                            color: TTColors.darkBlue),
                        title: const Text(
                          'Dashboard',
                          style: TextStyle(color: TTColors.darkBlue),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading:
                            const Icon(Icons.add, color: TTColors.darkBlue),
                        title: const Text(
                          'Add Event',
                          style: TextStyle(color: TTColors.darkBlue),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/addeventtheme');
                        },
                      ),
                      ListTile(
                        leading:
                            const Icon(Icons.event, color: TTColors.darkBlue),
                        title: const Text(
                          'View All Booking',
                          style: TextStyle(color: TTColors.darkBlue),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/adminviewbooking');
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.data_usage,
                            color: TTColors.darkBlue),
                        title: const Text(
                          'Users Data',
                          style: TextStyle(color: TTColors.darkBlue),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/userdata');
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.admin_panel_settings,
                            color: TTColors.darkBlue),
                        title: const Text(
                          'Admin Data',
                          style: TextStyle(color: TTColors.darkBlue),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/admindata');
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.person_add,
                            color: TTColors.darkBlue),
                        title: const Text(
                          'Add Admin',
                          style: TextStyle(color: TTColors.darkBlue),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/adminregister');
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.feedback,
                            color: TTColors.darkBlue),
                        title: const Text(
                          'Feedbacks',
                          style: TextStyle(color: TTColors.darkBlue),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/feedbacks');
                        },
                      ),
                      ListTile(
                        leading:
                            const Icon(Icons.logout, color: TTColors.darkBlue),
                        title: const Text(
                          'Logout',
                          style: TextStyle(color: TTColors.darkBlue),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/adminlogin');
                        },
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
