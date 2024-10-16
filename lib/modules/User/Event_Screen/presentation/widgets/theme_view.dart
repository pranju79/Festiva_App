import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_orientation_app/utils/components/tt_colors.dart';
import 'package:event_orientation_app/utils/components/tt_typography.dart';
import 'package:flutter/material.dart';
import 'theme_details_view.dart';

class ThemeView extends StatelessWidget {
 final String theme_type;
 final String eventname;
 final String email;
   const ThemeView({super.key, required this.theme_type,required this.eventname,required this.email});

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
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: TTColors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(theme_type ?? ''),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('theme collection').where('theme_type',isEqualTo: theme_type).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
            ),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final doc = snapshot.data!.docs[index];
              return GestureDetector(
                onTap: () {
                  final theme_id = doc.id;
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>ThemeDetailsView(theme_id: theme_id,eventname: eventname,email: email,)));
                },
                child: Card(
                  shadowColor: TTColors.black.withOpacity(0.5),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.network(
                          (doc['theme_image']),
                          fit: BoxFit.cover,
                          width: 100,
                          height: 100,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 100,
                              height: 100,
                              decoration: const BoxDecoration(gradient:  LinearGradient(colors: [TTColors.pink, TTColors.blue],)),
                              child: const Icon(Icons.celebration_rounded, color: Colors.white, size: 50),
                            );
                          },
                        ),
                      ),
                      Text('${doc["theme_title"]}', style: TTypography.textBlack14Bold),
                    ],
                  ),
                ),
              );
            },
          );
        }
      ),
    );
  }
}
