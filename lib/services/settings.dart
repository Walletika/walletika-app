import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';

import '../locales/locales.dart';
import '../utils/constants.dart';

class SettingsService extends GetxService {
  static const String _darkModeKey = 'darkMode';
  static const String _lanKey = 'language';
  static const String _networkKey = 'network';
  static const String _testnetHiddenKey = 'testnetHidden';

  late GetStorage _storage;
  late bool _isDarkMode;
  late String _currentLanguage;
  late String _currentNetwork;
  late bool _isTestnetHidden;

  bool get isDarkMode => _isDarkMode;

  String get currentLanguage => _currentLanguage;

  String get currentNetwork => _currentNetwork;

  bool get isTestnetHidden => _isTestnetHidden;

  ThemeMode get theme => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  Locale get locale => Locale(_currentLanguage);

  Future<SettingsService> init() async {
    _storage = GetStorage(
      AppInfo.name,
      await getApplicationSupportDirectory().then((dir) => dir.path),
    );

    _isDarkMode = _storage.read(_darkModeKey) ?? false;
    _currentLanguage =
        _storage.read(_lanKey) ?? AppTranslator.locales.keys.first;
    _currentNetwork = _storage.read(_networkKey) ?? AppInfo.network;
    _isTestnetHidden = _storage.read(_testnetHiddenKey) ?? true;

    return this;
  }

  Future<void> darkModeUpdate(bool enabled) async {
    await _storage.write(_darkModeKey, enabled);
    _isDarkMode = enabled;
  }

  Future<void> languageUpdate(String lang) async {
    await _storage.write(_lanKey, lang);
    _currentLanguage = lang;
  }

  Future<void> networkUpdate(String name) async {
    await _storage.write(_networkKey, name);
    _currentNetwork = name;
  }

  Future<void> testnetHiddenUpdate(bool enabled) async {
    await _storage.write(_testnetHiddenKey, enabled);
    _isTestnetHidden = enabled;
  }
}
