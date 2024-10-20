import 'package:event_orientation_app/utils/components/tt_colors.dart';
import 'package:event_orientation_app/utils/components/tt_typography.dart';
import 'package:event_orientation_app/utils/components/ui_helpers.dart';
import 'package:flutter/material.dart';

class BankPayment extends StatelessWidget {
  const BankPayment({super.key});

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
        title: const Text('Bank Details'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 350,
              decoration:
                  BoxDecoration(border: Border.all(color: TTColors.black)),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    UIHelpers.verticalSpaceMedium,
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Owner Name : ',
                          style: TTypography.textBlack18Bold,
                        ),
                        Text(
                          'Festiva Official',
                          style: TTypography.textBlack18,
                        ),
                      ],
                    ),
                    UIHelpers.verticalSpaceSmall,
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Bank Name : ',
                          style: TTypography.textBlack18Bold,
                        ),
                        Text(
                          'State Bank of India',
                          style: TTypography.textBlack18,
                        ),
                      ],
                    ),
                    UIHelpers.verticalSpaceSmall,
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Branch : ',
                          style: TTypography.textBlack18Bold,
                        ),
                        Text(
                          'Pune',
                          style: TTypography.textBlack18,
                        ),
                      ],
                    ),
                    UIHelpers.verticalSpaceSmall,
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Account No : ',
                          style: TTypography.textBlack18Bold,
                        ),
                        Text(
                          '65743856231',
                          style: TTypography.textBlack18,
                        ),
                      ],
                    ),
                    UIHelpers.verticalSpaceSmall,
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'IFSC Code : ',
                          style: TTypography.textBlack18Bold,
                        ),
                        Text(
                          'SBIN0548435',
                          style: TTypography.textBlack18,
                        ),
                      ],
                    ),
                    UIHelpers.verticalSpaceExtraLarge,
                    OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Cancel',
                          style: TTypography.textBlue20Bold,
                        ))
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 120,
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
    );
  }
}
