import 'package:walletika_sdk/walletika_sdk.dart';

abstract class WalletRepository {
  Future<List<WalletModel>> getAll();
}