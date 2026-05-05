import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  static const String rememberMeKey = 'remember_me';
  static const String emailKey = 'saved_email';
  static const String themeKey = 'app_theme';
  static const String fontSizeKey = 'font_size';
  static const String languageKey = 'language';
  static const String notificationEnabledKey = 'notification_enabled';

  static Future<void> saveRememberMe(bool rememberMe, String email) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(rememberMeKey, rememberMe);
    if (rememberMe) {
      await prefs.setString(emailKey, email);
    } else {
      await prefs.remove(emailKey);
    }
  }

  static Future<bool> getRememberMe() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(rememberMeKey) ?? false;
  }

  static Future<String?> getSavedEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(emailKey);
  }

  static Future<void> setTheme(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(themeKey, value);
  }

  static Future<String> getTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(themeKey) ?? 'system';
  }

  static Future<void> setFontSize(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(fontSizeKey, value);
  }

  static Future<String> getFontSize() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(fontSizeKey) ?? 'medium';
  }

  static Future<void> setLanguage(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(languageKey, value);
  }

  static Future<String> getLanguage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(languageKey) ?? 'vi';
  }

  static Future<void> setNotificationEnabled(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(notificationEnabledKey, value);
  }

  static Future<bool> getNotificationEnabled() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(notificationEnabledKey) ?? true;
  }

  static Future<void> resetAppSettings() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(themeKey);
    await prefs.remove(fontSizeKey);
    await prefs.remove(languageKey);
    await prefs.remove(notificationEnabledKey);
  }
}
