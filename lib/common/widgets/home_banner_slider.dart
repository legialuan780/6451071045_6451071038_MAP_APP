import 'package:flutter/material.dart';

class HomeBannerSlider extends StatelessWidget {
  const HomeBannerSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(12)),
      child: const Center(child: Text('Banner Slider')),
    );
  }
}
