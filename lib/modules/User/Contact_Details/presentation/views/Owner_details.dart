import 'package:event_orientation_app/modules/User/Contact_Details/presentation/widgets/contact_page.dart';
import 'package:event_orientation_app/modules/User/Contact_Details/presentation/widgets/payment_details.dart';
import 'package:event_orientation_app/utils/components/tt_colors.dart';
import 'package:event_orientation_app/utils/components/tt_icons.dart';
import 'package:flutter/material.dart';

class OwnerDetails extends StatelessWidget {
  const OwnerDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: TTColors.gradientColor,
              ),
            ),
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: const Icon(TTIcons.arrowback, color: TTColors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            bottom: const TabBar(
                indicatorColor: TTColors.blue,
                labelColor: TTColors.white,
                unselectedLabelColor: TTColors.grey,
                mouseCursor: SystemMouseCursors.click,
                tabs: [
                  Tab(
                    icon: Icon(
                      Icons.contact_page,
                      size: 30,
                    ),
                    text: 'Contact Details',
                  ),
                  Tab(
                    icon: Icon(
                      Icons.payment_outlined,
                      size: 30,
                    ),
                    text: 'Payment Details',
                  )
                ]),
          ),
          body: const TabBarView(children: [
            ContactPage(),
            PaymentDetails(),
          ]),
        ),
      ),
    );
  }
}
