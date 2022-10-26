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

  // Process States
  final ProcessState _darkModeUpdateState = ProcessState();
  final ProcessState _languageUpdateState = ProcessState();
  final ProcessState _networkUpdateState = ProcessState();

  // Event methods
  @override
  void onInit() {
    _isDarkMode = _repository.isDarkMode.obs;
    _currentLanguage = _repository.currentLanguage.obs;
    _currentNetwork = _repository.currentNetwork.obs;
    super.onInit();
  }

  // Getter methods
  Map<String, String> get languages => AppTranslator.locales;

  bool get isDarkMode => _isDarkMode.value;

  String get currentLanguage => _currentLanguage.value;

  String get currentNetwork => _currentNetwork.value;

  // Setter & Controller methods
  Future<void> darkModeUpdate(bool enabled) async {
    if (!_darkModeUpdateState.run()) return;

    await _repository.darkModeUpdate(enabled);
    Get.changeThemeMode(_repository.theme);
    _isDarkMode.value = enabled;

    _darkModeUpdateState.finished();
  }

  Future<void> languageUpdate(String? language) async {
    if (!_languageUpdateState.run()) return;

    await _repository.languageUpdate(language!);
    Get.updateLocale(_repository.locale);
    _currentLanguage.value = language;

    _languageUpdateState.finished();
  }

  Future<void> networkUpdate(String name) async {
    if (!_networkUpdateState.run()) return;

    await _repository.networkUpdate(name);
    _currentNetwork.value = name;

    _networkUpdateState.finished();
  }
}
