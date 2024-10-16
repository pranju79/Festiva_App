import 'package:flutter/material.dart';
import 'package:event_orientation_app/utils/components/tt_colors.dart';

class TermsAndPolicies extends StatelessWidget {
  const TermsAndPolicies({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Color> gradientColors = [
      TTColors.blue,
      TTColors.purple,
      TTColors.pink,
    ];

    return Scaffold(
      appBar: AppBar(
        foregroundColor: TTColors.white,
        title: const Text(
          'Terms and Policies',
          style: TextStyle(color: TTColors.white),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                TTColors.blue,
                TTColors.purple,
                TTColors.pink,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              gradientColors[0].withOpacity(0.9),
              gradientColors[1].withOpacity(0.9),
              gradientColors[2].withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: constraints.maxWidth,
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Terms and Conditions',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: TTColors.white,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '1. Introduction',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: TTColors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Welcome to Festiva App. By accessing or using our app, you agree to be bound by these Terms and Conditions.',
                      style: TextStyle(fontSize: 16, color: TTColors.white),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '2. Use of the App',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: TTColors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '- You must be at least 18 years old to use our app.\n'
                      '- You agree to use the app only for lawful purposes and in accordance with these Terms and Conditions.',
                      style: TextStyle(fontSize: 16, color: TTColors.white),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '3. Account Registration',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: TTColors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '- To access certain features of the app, you may need to register for an account.\n'
                      '- You must provide accurate and complete information during the registration process.\n'
                      '- You are responsible for maintaining the confidentiality of your account information.',
                      style: TextStyle(fontSize: 16, color: TTColors.white),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '4. Event Management',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: TTColors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '- Festiva App allows you to create, manage, and participate in events.\n'
                      '- You are responsible for the content you post and ensuring it complies with all applicable laws and regulations.',
                      style: TextStyle(fontSize: 16, color: TTColors.white),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '5. Payments and Refunds',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: TTColors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '- Payments for events or services may be processed through third-party payment processors.\n'
                      '- Refunds will be handled according to the policies of the specific event or service provider.',
                      style: TextStyle(fontSize: 16, color: TTColors.white),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '6. Intellectual Property',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: TTColors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '- All content and materials available on the app, including but not limited to text, graphics, logos, and software, are the property of Festiva App or its licensors.\n'
                      '- You may not use, reproduce, or distribute any content from the app without our prior written permission.',
                      style: TextStyle(fontSize: 16, color: TTColors.white),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '7. Termination',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: TTColors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '- We reserve the right to terminate or suspend your account at any time, without notice, for any reason, including if you violate these Terms and Conditions.',
                      style: TextStyle(fontSize: 16, color: TTColors.white),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '8. Limitation of Liability',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: TTColors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '- Festiva App is not liable for any indirect, incidental, or consequential damages arising out of or in connection with the use of our app.',
                      style: TextStyle(fontSize: 16, color: TTColors.white),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '9. Governing Law',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: TTColors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '- These Terms and Conditions are governed by and construed in accordance with the laws of [Your Country/State].',
                      style: TextStyle(fontSize: 16, color: TTColors.white),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '10. Changes to Terms',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: TTColors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '- We reserve the right to modify these Terms and Conditions at any time. Any changes will be posted on this page.',
                      style: TextStyle(fontSize: 16, color: TTColors.white),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '11. Contact Us',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: TTColors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '- If you have any questions about these Terms and Conditions, please contact us at [Contact Information].',
                      style: TextStyle(fontSize: 16, color: TTColors.white),
                    ),
                    SizedBox(height: 24),
                    Text(
                      'Privacy Policy',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: TTColors.white,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '1. Introduction',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: TTColors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'We are committed to protecting your privacy. This Privacy Policy explains how we collect, use, and share information about you when you use our app.',
                      style: TextStyle(fontSize: 16, color: TTColors.white),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '2. Information We Collect',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: TTColors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '- Personal Information: When you register for an account or use our services, we may collect personal information such as your name, email address, and phone number.\n'
                      '- Usage Data: We may collect information about your interactions with the app, such as your IP address, browser type, and usage patterns.',
                      style: TextStyle(fontSize: 16, color: TTColors.white),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '3. How We Use Your Information',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: TTColors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '- To provide, maintain, and improve our app and services.\n'
                      '- To communicate with you, including sending updates and promotional materials.\n'
                      '- To analyze usage patterns and improve user experience.',
                      style: TextStyle(fontSize: 16, color: TTColors.white),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '4. Sharing Your Information',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: TTColors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '- We may share your information with third-party service providers who assist us in operating our app and providing our services.\n'
                      '- We may also share your information to comply with legal obligations or to protect our rights.',
                      style: TextStyle(fontSize: 16, color: TTColors.white),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '5. Data Security',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: TTColors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '- We implement appropriate security measures to protect your information from unauthorized access, disclosure, alteration, or destruction.',
                      style: TextStyle(fontSize: 16, color: TTColors.white),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '6. Your Rights',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: TTColors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '- You have the right to access, update, or delete your personal information. You can do this by contacting us at [Contact Information].',
                      style: TextStyle(fontSize: 16, color: TTColors.white),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '7. Cookies',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: TTColors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '- Our app may use cookies to enhance user experience. You can choose to disable cookies through your browser settings, but this may affect your ability to use certain features of the app.',
                      style: TextStyle(fontSize: 16, color: TTColors.white),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '8. Changes to Privacy Policy',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: TTColors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '- We may update this Privacy Policy from time to time. Any changes will be posted on this page.',
                      style: TextStyle(fontSize: 16, color: TTColors.white),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '9. Contact Us',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: TTColors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '- If you have any questions about this Privacy Policy, please contact us at [Contact Information].',
                      style: TextStyle(fontSize: 16, color: TTColors.white),
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
