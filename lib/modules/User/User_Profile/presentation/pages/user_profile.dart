import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_orientation_app/utils/components/tt_colors.dart';
import 'package:event_orientation_app/utils/components/tt_icons.dart';
import 'package:event_orientation_app/utils/components/tt_typography.dart';
import 'package:event_orientation_app/utils/components/ui_helpers.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late Future<DocumentSnapshot>? _userData;
  String? email;

  final List<Color> gradientColors = [
    TTColors.blue,
    TTColors.purple,
    TTColors.pink,
  ];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)?.settings.arguments as String?;
      if (args != null) {
        setState(() {
          email = args;
          _userData = _fetchUserData(email!);
        });
      }
    });
  }

  Future<DocumentSnapshot> _fetchUserData(String email) async {
    return await FirebaseFirestore.instance
        .collection('UserRegister')
        .where('Email', isEqualTo: email)
        .limit(1)
        .get()
        .then((QuerySnapshot querySnapshot) {
      return querySnapshot.docs.first;
    });
  }

  void _onMenuOptionSelected(String option, Map<String, dynamic> userData) {
    if (option == 'Edit Profile') {
      _showEditProfileDialog(userData);
    } else if (option == 'Change Password') {
      _showChangePasswordDialog(userData['Email']);
    }
  }

  void _showEditProfileDialog(Map<String, dynamic> userData) {
    TextEditingController nameController =
        TextEditingController(text: userData['Name']);

    TextEditingController mobileController =
        TextEditingController(text: userData['MobileNo']);

    final List<String> genderOptions = ['Male', 'Female', 'Other'];
    String selectedGender = genderOptions.contains(userData['gender'])
        ? userData['gender']
        : genderOptions.first;

    final _formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(
            child: Text(
              'Edit Profile',
              style: TextStyle(
                color: Colors.purpleAccent,
              ),
            ),
          ),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildTextField('Name', nameController),
                  _buildTextField('Mobile No', mobileController),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: DropdownButtonFormField<String>(
                      value: selectedGender,
                      items: genderOptions
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, style: TTypography.textBlack16),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        labelText: 'Gender',
                        labelStyle: TTypography.textBlack16,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedGender = newValue!;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  )),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purpleAccent,
              ),
              child: const Text(
                'Save',
                style: TextStyle(
                  fontSize: 16,
                  color: TTColors.white,
                ),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _saveProfile(
                    nameController.text,
                    mobileController.text,
                    selectedGender,
                  );
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TTypography.textBlack16,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          fillColor: Colors.grey[200],
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$label cannot be empty';
          }
          return null;
        },
      ),
    );
  }

  void _saveProfile(String name, String mobile, String gender) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('UserRegister')
          .where('Email', isEqualTo: email)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot userDoc = querySnapshot.docs.first;

        await userDoc.reference.update({
          'Name': name,
          'MobileNo': mobile,
          'gender': gender,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile Updated Successfully!')),
        );

        setState(() {
          _userData = _fetchUserData(email!);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No user found to update.')),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Failed to update profile: ${error.toString()}')),
      );
    }
  }

  void _showChangePasswordDialog(String email) {
    TextEditingController currentPasswordController = TextEditingController();
    TextEditingController newPasswordController = TextEditingController();
    TextEditingController confirmNewPasswordController =
        TextEditingController();

    final _formKey = GlobalKey<FormState>();

    ValueNotifier<bool> _isCurrentPasswordVisible = ValueNotifier<bool>(false);
    ValueNotifier<bool> _isNewPasswordVisible = ValueNotifier<bool>(false);
    ValueNotifier<bool> _isConfirmPasswordVisible = ValueNotifier<bool>(false);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(
            child: Text(
              'Change Password',
              style: TextStyle(
                color: Colors.purpleAccent,
              ),
            ),
          ),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildPasswordField('Current Password',
                      currentPasswordController, _isCurrentPasswordVisible),
                  _buildPasswordField('New Password', newPasswordController,
                      _isNewPasswordVisible),
                  _buildConfirmPasswordField(
                      'Confirm New Password',
                      newPasswordController,
                      confirmNewPasswordController,
                      _isConfirmPasswordVisible),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel',
                  style: TextStyle(color: Colors.red, fontSize: 16)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purpleAccent,
              ),
              child: const Text(
                'Change',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await _updatePassword(
                    email,
                    currentPasswordController.text,
                    newPasswordController.text,
                    confirmNewPasswordController.text,
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildPasswordField(String label, TextEditingController controller,
      ValueNotifier<bool> isPasswordVisible) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ValueListenableBuilder<bool>(
        valueListenable: isPasswordVisible,
        builder: (context, value, child) {
          return TextFormField(
            controller: controller,
            obscureText: !value,
            decoration: InputDecoration(
              labelText: label,
              labelStyle: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              filled: true,
              fillColor: Colors.grey[200],
              suffixIcon: IconButton(
                icon: Icon(
                  value ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  isPasswordVisible.value = !isPasswordVisible.value;
                },
              ),
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '$label cannot be empty';
              }
              if (label == 'New Password' && value.length < 6) {
                return 'Password must be at least 6 characters long';
              }
              return null;
            },
          );
        },
      ),
    );
  }

  Widget _buildConfirmPasswordField(
      String label,
      TextEditingController newPasswordController,
      TextEditingController confirmNewPasswordController,
      ValueNotifier<bool> isPasswordVisible) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ValueListenableBuilder<bool>(
        valueListenable: isPasswordVisible,
        builder: (context, value, child) {
          return TextFormField(
            controller: confirmNewPasswordController,
            obscureText: !value,
            decoration: InputDecoration(
              labelText: label,
              labelStyle: const TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              filled: true,
              fillColor: Colors.grey[200],
              suffixIcon: IconButton(
                icon: Icon(
                  value ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  isPasswordVisible.value = !isPasswordVisible.value;
                },
              ),
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '$label cannot be empty';
              }
              if (value != newPasswordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          );
        },
      ),
    );
  }

  Future<void> _updatePassword(String email, String currentPassword,
      String newPassword, String confirmNewPassword) async {
    if (newPassword != confirmNewPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('New password and confirm password do not match!')),
      );
      return;
    }

    try {
      var userDoc = await FirebaseFirestore.instance
          .collection('UserRegister')
          .where('Email', isEqualTo: email)
          .limit(1)
          .get();

      if (userDoc.docs.isNotEmpty) {
        var userData = userDoc.docs.first.data() as Map<String, dynamic>;
        String storedPassword = userData['Password'];

        if (currentPassword != storedPassword) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Current password is incorrect!')),
          );
          return;
        }

        await userDoc.docs.first.reference.update({
          'Password': newPassword,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password changed successfully!')),
        );
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No user found to update.')),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Failed to change password: ${error.toString()}')),
      );
    }
  }

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
        title: const Text('Profile'),
        centerTitle: true,
        actions: [
          FutureBuilder<DocumentSnapshot>(
            future: _userData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var userData = snapshot.data!.data() as Map<String, dynamic>;
                return PopupMenuButton<String>(
                  icon: const Icon(Icons.edit, color: TTColors.white),
                  onSelected: (value) => _onMenuOptionSelected(value, userData),
                  itemBuilder: (BuildContext context) {
                    return [
                      const PopupMenuItem(
                        value: 'Edit Profile',
                        child: Text('Edit Profile',
                            style: TTypography.textBlack16),
                      ),
                      const PopupMenuItem(
                        value: 'Change Password',
                        child: Text('Change Password',
                            style: TTypography.textBlack16),
                      ),
                    ];
                  },
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
      body: _userData == null
          ? const Center(child: CircularProgressIndicator())
          : FutureBuilder<DocumentSnapshot>(
              future: _userData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return const Center(child: Text('Error fetching user data'));
                }
                if (!snapshot.hasData || !snapshot.data!.exists) {
                  return const Center(child: Text('User not found'));
                }

                var userData = snapshot.data!.data() as Map<String, dynamic>;
                String name = userData['Name'] ?? 'N/A';
                String email = userData['Email'] ?? 'N/A';
                String mobileNo = userData['MobileNo'] ?? 'N/A';
                String gender = userData['gender'] ?? 'N/A';
                String profileImageUrl = userData['profileImageUrl'] ??
                    'https://images.vexels.com/content/147101/preview/instagram-profile-button-68a534.png';

                return Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        gradientColors[0].withOpacity(0.2),
                        gradientColors[1].withOpacity(0.2),
                        gradientColors[2].withOpacity(0.2),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: CircleAvatar(
                            radius: 66,
                            backgroundColor: Colors.purpleAccent,
                            child: ClipOval(
                              child: Image.network(
                                profileImageUrl,
                                fit: BoxFit.cover,
                                width: 140,
                                height: 140,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(
                                    Icons.person,
                                    size: 66,
                                    color: Colors.purpleAccent,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        UIHelpers.verticalSpaceMedium,
                        Expanded(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              side: const BorderSide(
                                color: Colors.purpleAccent,
                                width: 2,
                              ),
                            ),
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildProfileRow(
                                    icon: TTIcons.profileRounded,
                                    label: 'Name',
                                    value: name,
                                  ),
                                  UIHelpers.verticalSpaceSmall,
                                  UIHelpers.listDividerBlack,
                                  UIHelpers.verticalSpaceSmall,
                                  _buildProfileRow(
                                    icon: TTIcons.mail,
                                    label: 'Email',
                                    value: email,
                                  ),
                                  UIHelpers.verticalSpaceSmall,
                                  UIHelpers.listDividerBlack,
                                  UIHelpers.verticalSpaceSmall,
                                  _buildProfileRow(
                                    icon: TTIcons.call,
                                    label: 'Mobile No',
                                    value: mobileNo,
                                  ),
                                  UIHelpers.verticalSpaceSmall,
                                  UIHelpers.listDividerBlack,
                                  UIHelpers.verticalSpaceSmall,
                                  _buildProfileRow(
                                    icon: Icons.male,
                                    label: 'Gender',
                                    value: gender,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget _buildProfileRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: gradientColors,
            ).createShader(bounds);
          },
          child: Icon(icon, size: 24),
        ),
        UIHelpers.horizontalSpaceRegular,
        Text('$label:', style: TTypography.textBlack18Bold),
        UIHelpers.horizontalSpaceTiny,
        Expanded(
          child: Text(
            value,
            style: TTypography.textBlack18Bold,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
