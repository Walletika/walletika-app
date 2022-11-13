import 'package:walletika_sdk/walletika_sdk.dart';

abstract class WalletRepository {
  Map<String, WalletEngine> engines = {};

  Stream<WalletEngine> getAll();

  int count();

  Future<bool> addNew({
    required String username,
    required String password,
    required String recoveryPassword,
  });

  Future<void> setFavorite(String address);
}
