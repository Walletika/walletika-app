import 'package:get/get.dart';

import '../../locales/locales.dart';
import '../../services/settings.dart';
import '../wallet/wallet.dart';

class SettingsController extends GetxController {
  // Data repository
  final SettingsService _repository = Get.find<SettingsService>();

  // States
  late RxBool _isDarkMode;
  late RxString _currentLanguage;
  late RxString _currentNetwork;
  late RxBool _isTestnetHidden;

  // Local data
  final WalletController _walletController = Get.find<WalletController>();

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
    await _repository.darkModeUpdate(enabled);
    Get.changeThemeMode(_repository.theme);
    _isDarkMode.value = enabled;
  }

  Future<void> languageUpdate(String? language) async {
    await _repository.languageUpdate(language!);
    Get.updateLocale(_repository.locale);
    _currentLanguage.value = language;
  }

  Future<void> networkUpdate(String name) async {
    await _repository.networkUpdate(name);
    _walletController.tokensUpdate();
    _walletController.transactionsUpdate();
    _currentNetwork.value = name;
  }

  Future<void> testnetHiddenUpdate(bool enabled) async {
    await _repository.testnetHiddenUpdate(enabled);
    _isTestnetHidden.value = enabled;
  }
}
