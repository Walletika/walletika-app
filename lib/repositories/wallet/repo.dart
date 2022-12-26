import '../../models/token.dart';
import '../../models/transaction.dart';
import '../../models/wallet.dart';

abstract class WalletRepository {
  Stream<WalletItemModel> getAll();

  int count();

  Future<bool> addNew({
    required String username,
    required String password,
    required String securityPassword,
  });

  Future<bool> remove(WalletItemModel wallet);

  Future<bool> loginValidate({
    required WalletItemModel wallet,
    required String password,
  });

  Future<bool> login({
    required WalletItemModel wallet,
    required String password,
    required String otpCode,
  });

  Future<void> logout(WalletItemModel wallet);

  Future<String?> getPrivateKey({
    required WalletItemModel wallet,
    required String otpCode,
  });

  Future<void> setFavorite(WalletItemModel wallet);

  Future<List<TokenItemModel>> tokens(WalletItemModel wallet);

  Future<void> addToken({
    required WalletItemModel wallet,
    required TokenItemModel token,
  });

  Future<bool> removeToken({
    required WalletItemModel wallet,
    required TokenItemModel token,
  });

  Future<List<TransactionItemModel>> transactions(WalletItemModel wallet);

  Future<String> backup({
    required String directory,
    String? password,
    required void Function(int value) progressCallback,
  });

  Future<bool> import({
    required String path,
    String? password,
    required void Function(int value) progressCallback,
  });

  String explorerURL(String address);
}
