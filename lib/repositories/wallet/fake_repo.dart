import 'package:walletika_creator/walletika_creator.dart';

import '../../models/wallet.dart';
import 'repo.dart';

class WalletFakeRepository extends WalletRepository {
  final List<WalletViewModel> _wallets = [
    WalletViewModel(
      username: 'Wallet1',
      address: '0x70463907F1aEe85619D8C248352d422681E304A1',
      dateCreated: DateTime.now(),
      isFavorite: true,
      isLogged: false,
    ),
    WalletViewModel(
      username: 'Wallet2',
      address: '0x81f4300AD8e46e2315A414DE387a23b84e9B8590',
      dateCreated: DateTime.now(),
      isFavorite: false,
      isLogged: false,
    ),
    WalletViewModel(
      username: 'Wallet3',
      address: '0x4520c0fb7aC21d52E089e49261FAC3e7424F9045',
      dateCreated: DateTime.now(),
      isFavorite: false,
      isLogged: false,
    )
  ];

  @override
  Stream<WalletViewModel> getAll() async* {
    for (WalletViewModel wallet in _wallets) {
      yield wallet;
    }
  }

  @override
  int count() => _wallets.length;

  @override
  Future<bool> addNew({
    required String username,
    required String password,
    required String securityPassword,
  }) async {
    final WalletInfoModel wallet = await walletGenerator(
      username: username,
      password: password,
      securityPassword: securityPassword.codeUnits,
      otpCode: currentOTPCode(
        otpKeyGenerator(
          username: username,
          password: password,
          securityPassword: securityPassword,
        ),
      ),
    );

    if (wallet.isValid) {
      _wallets.add(
        WalletViewModel(
          username: username,
          address: wallet.address!.hexEip55,
          dateCreated: DateTime.now(),
          isFavorite: false,
          isLogged: false,
        ),
      );

      return true;
    }

    return false;
  }

  @override
  Future<bool> loginValidate({
    required WalletViewModel currentWallet,
    required String password,
  }) async {
    return password == '123';
  }

  @override
  Future<bool> login({
    required WalletViewModel currentWallet,
    required String password,
    required String otpCode,
  }) async {
    currentWallet.isLogged = true;
    return true;
  }

  @override
  Future<void> setFavorite(WalletViewModel currentWallet) async {
    currentWallet.isFavorite = !currentWallet.isFavorite;
  }
}
