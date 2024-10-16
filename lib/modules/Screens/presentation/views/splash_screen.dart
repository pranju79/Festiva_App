import 'package:event_orientation_app/utils/components/tt_colors.dart';
import 'package:event_orientation_app/utils/components/tt_typography.dart';
import 'package:event_orientation_app/utils/components/ui_helpers.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  List<Map<String, String>> onboardingData = [
    {
      "image": "assets/splash_screen.png",
      "title": "Welcome to Event Planner",
      "subtitle": "Plan your events seamlessly with our app!"
    },
    {
      "image": "assets/splash_screen2.png",
      "title": "Easy Scheduling",
      "subtitle": "Schedule events and share them with friends and family."
    },
    {
      "image": "assets/event.png",
      "title": "Track Your Events",
      "subtitle": "Keep track of all your events in one place."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemCount: onboardingData.length,
            itemBuilder: (context, index) {
              return OnboardingPage(
                image: onboardingData[index]['image'] ?? '',
                title: onboardingData[index]['title'] ?? '',
                subtitle: onboardingData[index]['subtitle'] ?? '',
              );
            },
          ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                onboardingData.length,
                (index) => buildDot(index, context),
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            right: 20,
            child: GestureDetector(
              onTap: () {
                if (_currentPage == onboardingData.length - 1) {
                  Navigator.pushNamed(context, '/login');
                } else {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                }
              },
              child: Text(
                _currentPage == onboardingData.length - 1 ? 'Done' : 'Next',
                style: TTypography.textWhite18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDot(int index, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 15),
      height: 10,
      width: _currentPage == index ? 20 : 10,
      decoration: BoxDecoration(
        color: _currentPage == index ? TTColors.whiteShade : TTColors.grey,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;

  const OnboardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: TTColors.gradientColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            height: 300,
          ),
          UIHelpers.verticalSpaceMedium,
          UIHelpers.verticalSpaceSmall,
          Text(
            title,
            style: TTypography.textWhite24Bold,
            textAlign: TextAlign.center,
          ),
          UIHelpers.verticalSpaceRegular,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              subtitle,
              style: TTypography.text18ARGB,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
