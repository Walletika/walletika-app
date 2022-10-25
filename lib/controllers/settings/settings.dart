import 'package:get/get.dart';

import '../../locales/locales.dart';
import '../../services/settings.dart';
import '../../utils/process_state.dart';

class SettingsController extends GetxController {
  // Data repository
  final SettingsService _repository = Get.find<SettingsService>();

  // States
  late RxString _currentLanguage;
  late RxBool _isDarkMode;

  // Process States
  final ProcessState _languageUpdateState = ProcessState();
  final ProcessState _darkModeUpdateState = ProcessState();

  // Event methods
  @override
  void onInit() {
    _currentLanguage = _repository.currentLanguage.obs;
    _isDarkMode = _repository.isDarkMode.obs;
    super.onInit();
  }

  // Getter methods
  Map<String, String> get languages => AppTranslator.locales;

  String get currentLanguage => _currentLanguage.value;

  bool get isDarkMode => _isDarkMode.value;

  // Setter & Controller methods
  Future<void> languageUpdate(String? language) async {
    if (!_languageUpdateState.run()) return;

    await _repository.languageUpdate(language!);
    Get.updateLocale(_repository.locale);
    _currentLanguage.value = language;

    _languageUpdateState.finished();
  }

  Future<void> darkModeUpdate(bool enabled) async {
    if (!_darkModeUpdateState.run()) return;

    await _repository.darkModeUpdate(enabled);
    Get.changeThemeMode(_repository.theme);
    _isDarkMode.value = enabled;

    _darkModeUpdateState.finished();
  }
}
