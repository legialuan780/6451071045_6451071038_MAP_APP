import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/settings_controller.dart';
import '../routes/app_routes.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final SettingsController settingsController = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GetMaterialApp(
        title: 'Flutter E-Commerce',
        debugShowCheckedModeBanner: false,
        locale: settingsController.locale.value,
        themeMode: settingsController.themeMode.value,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          canvasColor: Colors.white,
          textTheme: ThemeData.light().textTheme.apply(
                fontSizeFactor: settingsController.textScaleFactor,
              ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
            foregroundColor: Colors.black,
          ),
        ),
        darkTheme: ThemeData.dark().copyWith(
          textTheme: ThemeData.dark().textTheme.apply(
                fontSizeFactor: settingsController.textScaleFactor,
              ),
        ),
        initialRoute: AppRoutes.splash,
        routes: AppRoutes.routes,
      );
    });
  }
}