import 'package:event_orientation_app/modules/User/EventBookForm/presentation/pages/EventBookForm.dart';
import 'package:event_orientation_app/utils/common/custom_button.dart';
import 'package:event_orientation_app/utils/components/tt_colors.dart';
import 'package:event_orientation_app/utils/components/tt_icons.dart';
import 'package:event_orientation_app/utils/components/tt_typography.dart';
import 'package:event_orientation_app/utils/components/ui_helpers.dart';
import 'package:flutter/material.dart';

class PackageDetails extends StatelessWidget {
  final String eventname;
  final String themename;
  final String email;
  const PackageDetails({super.key,required this.eventname,required this.themename,required this.email});

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
      body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GradientText('Packages', gradient: TTColors.gradientColor,style: TTypography.textBlack30,),
                  UIHelpers.verticalSpaceMedium,
                  const Row(
                    children: [
                      Icon(TTIcons.event,color: TTColors.pink),
                      Text('10,000 -50,000 [For 100 seating]',style: TTypography.textBlack16Bold,),
                    ],
                  ),
                  UIHelpers.verticalSpaceSmall,
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Text('1.Catering Policy \n2.Decor Policy \n3.Space[for Indoor or Outdoor] \n4.DJ Policy',style: TTypography.textBlack18,),
                  ),
                  UIHelpers.verticalSpaceMedium,
                   const Row(
                     children: [
                      Icon(TTIcons.event,color: TTColors.pink,),
                       Text('50,000 -1,00,000 [For 200 seating]',style: TTypography.textBlack16Bold,),
                     ],
                   ),
                  UIHelpers.verticalSpaceSmall,
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Text('1.Catering Policy \n2.Decor Policy \n3.Space[for Indoor or Outdoor] \n4.DJ Policy \nFeatures[Parking available] ',style: TTypography.textBlack18,),
                  ),
                  UIHelpers.verticalSpaceMedium,
                   const Row(
                     children: [
                      Icon(TTIcons.event,color: TTColors.pink,),
                       Text('1,00,000- 1,50,000 [For 300 seating]',style: TTypography.textBlack16Bold,),
                     ],
                   ),
                  UIHelpers.verticalSpaceSmall,
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Text('1.Catering Policy \n2.Decor Policy \n3.Space[for Indoor or Outdoor] \n4.DJ Policy \nFeatures[Parking available]',style: TTypography.textBlack18,),
                  ),
                  UIHelpers.verticalSpaceMedium,
                   const Row(
                     children: [
                      Icon(TTIcons.event,color: TTColors.pink,),
                       Text('2,00,000- 3,50,000 [For 400 seating]',style: TTypography.textBlack16Bold,),
                     ],
                   ),
                  UIHelpers.verticalSpaceSmall,
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Text('1.Catering Policy \n2.Decor Policy \n3.Space[for Indoor or Outdoor] \n4.DJ Policy \n5.Live Entertainment \nFeatures[Parking available]',style: TTypography.textBlack18,),
                  ),
                  UIHelpers.verticalSpaceMedium,
                   const Row(
                     children: [
                      Icon(TTIcons.event,color: TTColors.pink,),
                       Text('3,50,000-5,00,000 [For 500 seating]',style: TTypography.textBlack16Bold,),
                     ],
                   ),
                  UIHelpers.verticalSpaceSmall,
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Text('1.Catering Policy \n2.Decor Policy \n3.Space[for Indoor or Outdoor] \n4.DJ Policy \n5.Live Entertainment \nFeatures[Parking available]',style: TTypography.textBlack18,),
                  ),
                  UIHelpers.verticalSpaceMedium,
                   UIHelpers.verticalSpaceMedium,
                   const Row(
                     children: [
                      Icon(TTIcons.event,color: TTColors.pink,),
                       Text('5,00,000-10,00,000 [For 1000 seating]',style: TTypography.textBlack16Bold,),
                     ],
                   ),
                  UIHelpers.verticalSpaceSmall,
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Text('1.Catering Policy \n2.Decor Policy \n3.Space[for Indoor or Outdoor] \n4.DJ Policy \n5.Live Entertainment \nFeatures[Parking available]',style: TTypography.textBlack18,),
                  ),
                  UIHelpers.verticalSpaceLarge,
                  GradientButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (_)=> EventBookForm(eventname: eventname,themename: themename,email: email,)));
                    },
                    child: const Text('Book Now', style: TTypography.textWhite20Bold,)
                  )
                ],
              ),
            ),
          ),
    );
  }
}