import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/main_navigation_controller.dart';
import 'home_screen.dart';
import '../profile/profile_screen.dart';
import '../mystore/mystore_screen.dart';
import '../wishlist/wishlist_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  final int initialIndex;
  const MainNavigationScreen({super.key}) : initialIndex = 0;
  const MainNavigationScreen.withIndex({
    super.key,
    required this.initialIndex,
  });

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  late final MainNavigationController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<MainNavigationController>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      controller.setIndex(widget.initialIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    final MainNavigationController controller =
        this.controller;
    final List<Widget> screens = <Widget>[
      HomeScreen(),
      const MystoreScreen(),
      const WishlistScreen(),
      const ProfileScreen(),
    ];

    return Obx(
      () => Scaffold(
        body: screens[controller.currentIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          type: BottomNavigationBarType.fixed,
          onTap: controller.setIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Store',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border),
              label: 'Wishlist',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}