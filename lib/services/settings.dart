import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../locales/locales.dart';
import '../utils/constants.dart';

class SettingsService extends GetxService {
  final GetStorage storage = GetStorage(AppInfo.name);
  static const String _darkModeKey = 'darkMode';
  static const String _lanKey = 'language';
  static const String _networkKey = 'network';
  static const String _testnetHiddenKey = 'testnetHidden';

  late bool isDarkMode;
  late String currentLanguage;
  late String currentNetwork;
  late bool isTestnetHidden;

  ThemeMode get theme => isDarkMode ? ThemeMode.dark : ThemeMode.light;

  Locale get locale => Locale(currentLanguage);

  Future<SettingsService> init() async {
    isDarkMode = storage.read(_darkModeKey) ?? false;
    currentLanguage = storage.read(_lanKey) ?? AppTranslator.locales.keys.first;
    currentNetwork = storage.read(_networkKey) ?? "Ethereum";
    isTestnetHidden = storage.read(_testnetHiddenKey) ?? false;
    return this;
  }

  Future<void> darkModeUpdate(bool enabled) async {
    await storage.write(_darkModeKey, enabled);
    isDarkMode = enabled;
  }

  Future<void> languageUpdate(String lang) async {
    await storage.write(_lanKey, lang);
    currentLanguage = lang;
  }

  Future<void> networkUpdate(String name) async {
    await storage.write(_networkKey, name);
    currentNetwork = name;
  }

  Future<void> testnetHiddenUpdate(bool enabled) async {
    await storage.write(_testnetHiddenKey, enabled);
    isTestnetHidden = enabled;
  }
}
