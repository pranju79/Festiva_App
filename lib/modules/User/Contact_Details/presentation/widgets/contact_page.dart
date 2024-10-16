import 'package:event_orientation_app/utils/components/tt_colors.dart';
import 'package:event_orientation_app/utils/components/tt_icons.dart';
import 'package:event_orientation_app/utils/components/tt_typography.dart';
import 'package:event_orientation_app/utils/components/ui_helpers.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                height: 200,
                width: 500,
                decoration: BoxDecoration(
                  border: Border.all(color: TTColors.blue,width: 2),
                  color: TTColors.white,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  children: [
                    UIHelpers.verticalSpaceRegular,
                   ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (Rect bounds) {
                      return const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [TTColors.pink, TTColors.blue],
                        ).createShader(bounds);
                    },
                    child: const Icon(TTIcons.mail,size: 60,),
                   ),
                   const Text('Email',style: TTypography.textBlack22Bold,),
                   UIHelpers.verticalSpaceRegular,
                   GestureDetector(
                    onTap: (){
                       _launchMail();
                    },
                     child: const Text('telphatech@gmail.com',style: TextStyle(decoration: TextDecoration.underline,fontSize: 18,color: TTColors.blue,decorationColor: TTColors.blue),))
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                height: 200,
                width: 500,
                decoration: BoxDecoration(
                  border: Border.all(color: TTColors.blue,width: 2),
                  color: TTColors.white,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  children: [
                    UIHelpers.verticalSpaceRegular,
                   ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (Rect bounds) {
                      return const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [TTColors.pink, TTColors.blue],
                        ).createShader(bounds);
                    },
                    child: const Icon(TTIcons.call,size: 60,),
                   ),
                   const Text('Phone',style: TTypography.textBlack22Bold,),
                   UIHelpers.verticalSpaceRegular,
                   GestureDetector(
                    onTap: (){
                       _launchPhoneDailer('8421835869');
                    },
                     child: const Text('\t+918421835869',style: TextStyle(decoration: TextDecoration.underline,fontSize: 18,color: TTColors.blue,decorationColor: TTColors.blue),))
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                height: 200,
                width: 500,
                decoration: BoxDecoration(
                  border: Border.all(color: TTColors.blue,width: 2),
                  color: TTColors.white,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  children: [
                    UIHelpers.verticalSpaceRegular,
                   ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (Rect bounds) {
                      return const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [TTColors.pink, TTColors.blue],
                        ).createShader(bounds);
                    },
                    child: const Icon(TTIcons.location,size: 60,),
                   ),
                   const Text('Location',style: TTypography.textBlack22Bold,),
                   UIHelpers.verticalSpaceRegular,
                   GestureDetector(
                    onTap: () async {
                      final url = Uri.parse(
                      'https://www.google.com/maps/place/Telphatech+LLP/@18.5939629,73.8146337,17z/data=!3m1!4b1!4m6!3m5!1s0x3bc2b97f1230d2ab:0xf41fb59379af829e!8m2!3d18.5939629!4d73.8172086!16s%2Fg%2F11tng9ld0j?entry=ttu');
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  }
                    },
                     child: const Text('\tPune',style: TextStyle(decoration: TextDecoration.underline,fontSize: 18,color: TTColors.blue,decorationColor: TTColors.blue),))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
_launchMail() async {
  const url = 'mailto:telphatech@gmail.com?subject=Hello&body=Hello%20Telphatech';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw "Could not launch $url";
  }
}

_launchPhoneDailer(String phoneNumber) async {
  final url = 'tel:$phoneNumber';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw "Could not launch $url";
  }
}
