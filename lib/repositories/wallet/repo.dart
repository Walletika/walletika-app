import '../../models/token.dart';
import '../../models/transaction.dart';
import '../../models/wallet.dart';

abstract class WalletRepository {
  Stream<WalletViewModel> getAll();

  int count();

  Future<bool> addNew({
    required String username,
    required String password,
    required String securityPassword,
  });

  Future<bool> remove(WalletViewModel currentWallet);

  Future<bool> loginValidate({
    required WalletViewModel currentWallet,
    required String password,
  });

  Future<bool> login({
    required WalletViewModel currentWallet,
    required String password,
    required String otpCode,
  });

  Future<void> logout(WalletViewModel currentWallet);

  Future<String?> getPrivateKey(String otpCode);

  Future<void> setFavorite(WalletViewModel currentWallet);

  Future<List<TokenItemModel>> tokens(WalletViewModel currentWallet);

  Future<void> addToken(TokenItemModel token);

  Future<bool> removeToken(TokenItemModel token);

  Future<List<TransactionItemModel>> transactions(
    WalletViewModel currentWallet,
  );

  Future<String> backup({
    required String directory,
    String? password,
    required void Function(int value) progressCallback,
  });

  Future<void> import({
    required String path,
    String? password,
    required void Function(int value) progressCallback,
  });

  String explorerURL(String address);
}
