import 'package:get/get.dart';
import 'package:walletika_creator/walletika_creator.dart';

import '../../utils/constants.dart';
import '../wallet/wallet_manager.dart';

class AuthSetupController extends GetxController {
  // Data repository
  final WalletManagerController _walletManagerController =
      Get.find<WalletManagerController>();

  // States
  final RxInt _currentTabIndex = 0.obs;

  // Local Data
  static const int _totalTabs = 4;
  late String _password;
  late String _otpKey;

  // Getter methods
  int get currentTabIndex => _currentTabIndex.value;

  String get address => _walletManagerController.currentWallet.address;

  String get username => _walletManagerController.currentWallet.username;

  String get otpKey => _otpKey;

  String get otpKeyFormat =>
      'otpauth://totp/${AppInfo.name}:$username?secret=$_otpKey&issuer=${AppInfo.name}';

  // Setter & Controller methods
  int toNextTab() {
    if (_currentTabIndex.value < _totalTabs - 1) _currentTabIndex.value++;
    return _currentTabIndex.value;
  }

  int toPreviousTab() {
    if (_currentTabIndex.value > 0) _currentTabIndex.value--;
    return _currentTabIndex.value;
  }

  Future<bool> verification({
    required String password,
    required String securityPassword,
  }) async {
    final key = otpKeyGenerator(
      username: username,
      password: password,
      securityPassword: securityPassword,
    );

    final WalletInfoModel wallet = await walletGenerator(
      username: username,
      password: password,
      securityPassword: securityPassword.codeUnits,
      otpCode: currentOTPCode(key),
    );

    if (wallet.isValid && wallet.address!.hexEip55 == address) {
      _password = password;
      _otpKey = key;
      return true;
    }

    return false;
  }

  Future<bool> confirmation(String otpCode) async {
    final String currentCode = currentOTPCode(_otpKey);
    final bool isValid = (currentCode == otpCode);

    if (isValid) {
      await _walletManagerController.login(
        password: _password,
        otpCode: currentCode,
      );
    }

    return isValid;
  }
}
