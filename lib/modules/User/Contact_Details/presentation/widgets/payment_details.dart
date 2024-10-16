import 'package:event_orientation_app/modules/User/Contact_Details/presentation/widgets/bank_payment.dart';
import 'package:event_orientation_app/modules/User/Contact_Details/presentation/widgets/upi_payment.dart';
import 'package:event_orientation_app/utils/components/tt_colors.dart';
import 'package:event_orientation_app/utils/components/tt_typography.dart';
import 'package:event_orientation_app/utils/components/ui_helpers.dart';
import 'package:flutter/material.dart';

class PaymentDetails extends StatelessWidget {
  const PaymentDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 300,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: TTColors.black)
          ),
          child: Column(
            children: [
              UIHelpers.verticalSpaceMedium,
              const Text('Payment Mode',style: TTypography.textBlack26,),
              UIHelpers.verticalSpaceLargePlus,
              ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor:WidgetStatePropertyAll(TTColors.blue),
                ),
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (_)=> const UPIPayment()));
                },
                 child: const Padding(
                   padding: EdgeInsets.all(8.0),
                   child: Text('UPI Or Scan QR Code',style: TTypography.textWhite16Bold,),
                 ),
                 ),
                 UIHelpers.verticalSpaceLarge,
              ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor:WidgetStatePropertyAll(TTColors.blue),
                ),
                onPressed: (){
                   Navigator.of(context).push(MaterialPageRoute(builder: (_)=> const BankPayment()));
                },
                 child: const Padding(
                   padding: EdgeInsets.all(8.0),
                   child: Text('Bank Transfer',style: TTypography.textWhite18Bold,),
                 ),
                 )
            ],
          ),
        ),
      ),
    );
  }
}

