import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/preferences_helper.dart';

class SettingsController extends GetxController {
  final Rx<ThemeMode> themeMode = ThemeMode.system.obs;
  final RxString fontSize = 'medium'.obs;
  final Rx<Locale> locale = const Locale('vi').obs;

  @override
  void onInit() {
    super.onInit();
    loadSettings();
  }

  Future<void> loadSettings() async {
    final String theme = await PreferencesHelper.getTheme();
    if (theme == 'light') {
      themeMode.value = ThemeMode.light;
    } else if (theme == 'dark') {
      themeMode.value = ThemeMode.dark;
    } else {
      themeMode.value = ThemeMode.system;
    }

    fontSize.value = await PreferencesHelper.getFontSize();
    final String lang = await PreferencesHelper.getLanguage();
    locale.value = Locale(lang);
    Get.updateLocale(locale.value);
  }

  Future<void> changeTheme(String value) async {
    await PreferencesHelper.setTheme(value);
    if (value == 'light') {
      themeMode.value = ThemeMode.light;
    } else if (value == 'dark') {
      themeMode.value = ThemeMode.dark;
    } else {
      themeMode.value = ThemeMode.system;
    }
  }

  Future<void> changeFontSize(String value) async {
    await PreferencesHelper.setFontSize(value);
    fontSize.value = value;
  }

  Future<void> changeLanguage(String value) async {
    await PreferencesHelper.setLanguage(value);
    locale.value = Locale(value);
    Get.updateLocale(locale.value);
  }
}
