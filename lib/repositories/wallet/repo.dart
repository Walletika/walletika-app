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

  Future<bool> remove(WalletViewModel wallet);

  Future<bool> loginValidate({
    required WalletViewModel wallet,
    required String password,
  });

  Future<bool> login({
    required WalletViewModel wallet,
    required String password,
    required String otpCode,
  });

  Future<void> logout(WalletViewModel wallet);

  Future<String?> getPrivateKey({
    required WalletViewModel wallet,
    required String otpCode,
  });

  Future<void> setFavorite(WalletViewModel wallet);

  Future<List<TokenItemModel>> tokens(WalletViewModel wallet);

  Future<void> addToken({
    required WalletViewModel wallet,
    required TokenItemModel token,
  });

  Future<bool> removeToken({
    required WalletViewModel wallet,
    required TokenItemModel token,
  });

  Future<List<TransactionItemModel>> transactions(
    WalletViewModel wallet,
  );

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
