//Pooja Kaloji

import 'package:event_orientation_app/utils/components/tt_colors.dart';
import 'package:event_orientation_app/utils/components/tt_icons.dart';
import 'package:event_orientation_app/utils/components/tt_typography.dart';
import 'package:flutter/material.dart';

class AddData extends StatelessWidget {
  const AddData({super.key});

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
      ),
      body: Center(
        child: Container(
          decoration: const BoxDecoration(gradient: TTColors.gradientColor),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.white),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/addeventform');
                    },
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            TTIcons.add_event,
                            color: TTColors.pink,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Add Event',
                            style: TTypography.textBlack18,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.white),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/addthemeform');
                    },
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            TTIcons.add_theme,
                            color: TTColors.pink,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Add Themes',
                            style: TTypography.textBlack18,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
