import 'package:event_orientation_app/utils/components/tt_colors.dart';
import 'package:event_orientation_app/utils/components/tt_typography.dart';
import 'package:event_orientation_app/utils/components/ui_helpers.dart';
import 'package:flutter/material.dart';

class UPIPayment extends StatelessWidget {
  const UPIPayment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: TTColors.gradientColor,
          ),
        ),
        automaticallyImplyLeading: false,
        foregroundColor: TTColors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Payment Details'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(border: Border.all(color: TTColors.black)),
          child: Column(
            children: [
              UIHelpers.verticalSpaceLarge,
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Owner Name :',
                    style: TTypography.textBlack20Bold,
                  ),
                  Text(
                    'Telphatech LLP',
                    style: TTypography.textBlack20,
                  )
                ],
              ),
              UIHelpers.verticalSpaceLargePlus,
              const Image(
                  image: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT_LoDiVC564RDGwOpLwdfKwnYSoKwmQjD-Yg&s')),
              UIHelpers.verticalSpaceLarge,
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('UPI_ID: ', style: TTypography.textBlack16Bold),
                  Text('telphatech@okaxisbank', style: TTypography.textBlack16)
                ],
              ),
              const SizedBox(
                height: 90,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 239, 243, 145),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.warning_amber_rounded,
                              size: 20,
                              color: TTColors.danger,
                            ),
                            Text(
                              ' Before Processing Payment Please Contact Owner',
                              maxLines: 2,
                              style: TextStyle(fontSize: 11),
                            )
                          ],
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/ownerdetails');
                            },
                            child: const Text(
                              'Contact Us',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: TTColors.blue,
                                  decoration: TextDecoration.underline,
                                  decorationColor: TTColors.blue),
                            ))
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
