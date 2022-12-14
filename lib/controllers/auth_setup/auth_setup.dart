import 'dart:convert';

import 'package:get/get.dart';
import 'package:walletika_sdk/walletika_sdk.dart';

import '../../utils/constants.dart';
import '../wallet/wallet.dart';

class AuthSetupController extends GetxController {
  // Data repository
  final WalletController _walletController = Get.find<WalletController>();

  // Local Data
  late String _password;
  late String _otpKey;

  // Getter methods
  String get address => _walletController.currentWallet!.address;

  String get username => _walletController.currentWallet!.username;

  String get otpKey => _otpKey;

  String get otpKeyFormat =>
      'otpauth://totp/${AppInfo.name}:$username?secret=$_otpKey&issuer=${AppInfo.name}';

  // Setter & Controller methods
  Future<bool> verification({
    required String password,
    required String securityPassword,
  }) async {
    final key = otpKeyGenerator(
      username: username,
      password: password,
      securityPassword: securityPassword,
    );

    final WalletGeneratorInfo? wallet = await walletGenerator(
      username: username,
      password: password,
      securityPassword: utf8.encoder.convert(securityPassword),
      createNew: true,
    );

    if (wallet != null && wallet.address.hexEip55 == address) {
      _password = password;
      _otpKey = key;
      return true;
    }

    return false;
  }

  Future<bool> confirmation(String otpCode) async {
    final String currentCode = currentOTPCode(_otpKey);

    if (currentCode == otpCode) {
      return await _walletController.login(
        password: _password,
        otpCode: currentCode,
      );
    }

    return false;
  }
}
