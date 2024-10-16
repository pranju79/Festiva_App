import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_orientation_app/utils/common/custom_button.dart';
import 'package:event_orientation_app/utils/components/tt_colors.dart';
import 'package:event_orientation_app/utils/components/tt_typography.dart';
import 'package:event_orientation_app/utils/components/ui_helpers.dart';
import 'package:flutter/material.dart';

import 'package_details.dart';

class ThemeDetailsView extends StatelessWidget {
  final String? theme_id;
  final String eventname;
  final String email;
  const ThemeDetailsView({super.key, required this.theme_id, required this.eventname,required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient:TTColors.gradientColor,
          ),
        ),
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.arrow_back, color: TTColors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('theme collection').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error loading data.'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          var doc;
          try {
            doc = snapshot.data!.docs.firstWhere((doc) => doc.id == theme_id);
          } catch (e) {
            return const Center(child: Text('Data not found.'));
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${doc['theme_title']}', style: TTypography.textBlack30,),
                  UIHelpers.verticalSpaceTiny,
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT_ehbCWzYtrW16rkIA-HH7R7Ir6zbPUIMPGA&s',
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                  ),
                  UIHelpers.verticalSpaceSmall,
                  const Text('Description :', style: TTypography.textBlack22Bold,),
                  UIHelpers.verticalSpaceRegular,
                  Text('${doc['theme_description']}', style: TTypography.textBlack18,),
                  UIHelpers.verticalSpaceRegular,
                  const Text('Decoration :', style: TTypography.textBlack22Bold,),
                  UIHelpers.verticalSpaceRegular,
                  Text('${doc['theme_decoration']}', style: TTypography.textBlack18,),
                  UIHelpers.verticalSpaceRegular,
                  const Text('Activities :', style: TTypography.textBlack22Bold,),
                  UIHelpers.verticalSpaceRegular,
                  Text('${doc['theme_activites']}', style: TTypography.textBlack18,),
                  UIHelpers.verticalSpaceMedium,
                  GradientButton(
                    onPressed: () {
                      final String themename= doc['theme_title'];
                      Navigator.of(context).push(MaterialPageRoute(builder: (_)=> PackageDetails(themename: themename,eventname: eventname,email: email,)));
                    },
                    child: const Text('Packages', style: TTypography.textWhite20Bold,)
                  )
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}