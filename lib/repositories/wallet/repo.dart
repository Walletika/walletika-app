import 'package:walletika_sdk/walletika_sdk.dart';

abstract class WalletRepository {
  Map<String, WalletEngine> engines = {};

  Stream<WalletEngine> getAll();

  int count();
}
