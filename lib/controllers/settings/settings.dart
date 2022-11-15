import 'package:get/get.dart';

import '../../locales/locales.dart';
import '../../services/settings.dart';
import '../../utils/process_state.dart';

class SettingsController extends GetxController {
  // Data repository
  final SettingsService _repository = Get.find<SettingsService>();

  // States
  late RxBool _isDarkMode;
  late RxString _currentLanguage;
  late RxString _currentNetwork;
  late RxBool _isTestnetHidden;

  // Process States
  final ProcessState _darkModeUpdateState = ProcessState();
  final ProcessState _languageUpdateState = ProcessState();
  final ProcessState _networkUpdateState = ProcessState();
  final ProcessState _testnetHiddenUpdateState = ProcessState();

  // Event methods
  @override
  void onInit() {
    _isDarkMode = _repository.isDarkMode.obs;
    _currentLanguage = _repository.currentLanguage.obs;
    _currentNetwork = _repository.currentNetwork.obs;
    _isTestnetHidden = _repository.isTestnetHidden.obs;
    super.onInit();
  }

  // Getter methods
  Map<String, String> get languages => AppTranslator.locales;

  bool get isDarkMode => _isDarkMode.value;

  String get currentLanguage => _currentLanguage.value;

  String get currentNetwork => _currentNetwork.value;

  bool get isTestnetHidden => _isTestnetHidden.value;

  // Setter & Controller methods
  Future<void> darkModeUpdate(bool enabled) async {
    if (!_darkModeUpdateState.run()) return;

    try {
      await _repository.darkModeUpdate(enabled);
      Get.changeThemeMode(_repository.theme);
      _isDarkMode.value = enabled;
    } catch (e) {
      rethrow;
    } finally {
      _darkModeUpdateState.done();
    }
  }

  Future<void> languageUpdate(String? language) async {
    if (!_languageUpdateState.run()) return;

    try {
      await _repository.languageUpdate(language!);
      Get.updateLocale(_repository.locale);
      _currentLanguage.value = language;
    } catch (e) {
      rethrow;
    } finally {
      _languageUpdateState.done();
    }
  }

  Future<void> networkUpdate(String name) async {
    if (!_networkUpdateState.run()) return;

    try {
      await _repository.networkUpdate(name);
      _currentNetwork.value = name;
    } catch (e) {
      rethrow;
    } finally {
      _networkUpdateState.done();
    }
  }

  Future<void> testnetHiddenUpdate(bool enabled) async {
    if (!_testnetHiddenUpdateState.run()) return;

    try {
      await _repository.testnetHiddenUpdate(enabled);
      _isTestnetHidden.value = enabled;
    } catch (e) {
      rethrow;
    } finally {
      _testnetHiddenUpdateState.done();
    }
  }
}
