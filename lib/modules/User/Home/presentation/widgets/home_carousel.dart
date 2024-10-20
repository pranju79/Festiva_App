import 'package:carousel_slider/carousel_slider.dart';
import 'package:event_orientation_app/utils/components/tt_colors.dart';
import 'package:flutter/material.dart';

class CarouselWidget extends StatelessWidget {
  final List<String> imgList = [
    'assets/event1.jpg',
    'assets/event2.jpg',
    'assets/event3.jpg',
  ];

  CarouselWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: const [
          BoxShadow(
            color: TTColors.black12,
            blurRadius: 10.0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: CarouselSlider(
          options: CarouselOptions(
            height: MediaQuery.sizeOf(context).height * 0.25,
            autoPlay: true,
            viewportFraction: 1.0,
            enlargeCenterPage: true,
          ),
          items: imgList
              .map((item) => SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(item, fit: BoxFit.cover),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
