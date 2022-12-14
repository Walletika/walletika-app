import '../../models/token.dart';
import '../../models/wallet.dart';

abstract class WalletRepository {
  Stream<WalletViewModel> getAll();

  int count();

  Future<bool> addNew({
    required String username,
    required String password,
    required String securityPassword,
  });

  Future<bool> loginValidate({
    required WalletViewModel currentWallet,
    required String password,
  });

  Future<bool> login({
    required WalletViewModel currentWallet,
    required String password,
    required String otpCode,
  });

  Future<void> setFavorite(WalletViewModel currentWallet);

  Future<List<TokenItemModel>> tokens(WalletViewModel currentWallet);
}
