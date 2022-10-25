import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../locales/locales.dart';

class SettingsService extends GetxService {
  final GetStorage storage = GetStorage();
  static const String _lanKey = 'language';
  static const String _darkModeKey = 'darkMode';

  late String currentLanguage;
  late bool isDarkMode;

  ThemeMode get theme => isDarkMode ? ThemeMode.dark : ThemeMode.light;

  Locale get locale => Locale(currentLanguage);

  Future<SettingsService> init() async {
    currentLanguage = storage.read(_lanKey) ?? AppTranslator.locales.keys.first;
    isDarkMode = storage.read(_darkModeKey) ?? false;
    return this;
  }

  Future<void> languageUpdate(String lang) async {
    await storage.write(_lanKey, lang);
    currentLanguage = lang;
  }

  Future<void> darkModeUpdate(bool enabled) async {
    await storage.write(_darkModeKey, enabled);
    isDarkMode = enabled;
  }
}
