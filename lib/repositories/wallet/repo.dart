import 'package:walletika_sdk/walletika_sdk.dart';

abstract class WalletRepository {
  Map<String, WalletEngine> engines = {};

  Stream<WalletEngine> getAll();

  int count();

  Future<bool> addNew({
    required String username,
    required String password,
    required String securityPassword,
  });

  Future<bool> loginValidate({
    required String address,
    required String password,
  });

  Future<bool> login({
    required String address,
    required String password,
    required String otpCode,
  });

  Future<void> setFavorite(String address);
}
