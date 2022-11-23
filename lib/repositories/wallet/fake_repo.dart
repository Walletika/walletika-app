import 'dart:typed_data';

import 'package:walletika_creator/walletika_creator.dart';
import 'package:walletika_sdk/walletika_sdk.dart';
import 'package:web3dart/web3dart.dart';

import 'repo.dart';

class WalletFakeRepository extends WalletRepository {
  final Map<String, String> _wallets = {
    'Wallet 1': '0x1755cceE2BCb80fb7f453afa523F2C13f024E1B5',
    'Wallet 2': '0xA9e3105c94F99b570e538F012B0E4944C0C7dD58',
    'Wallet 3': '0x8357648712DE4DB19BF17E27b8f10b7d16A3a5Bb',
  };

  @override
  Stream<WalletEngine> getAll() async* {
    final Map<String, WalletEngine> result = {};

    for (int i = 0; i < _wallets.length; i++) {
      final String username = _wallets.keys.toList()[i];
      final String address = _wallets[username]!;
      final WalletEngine engine = engines[address] ??
          WalletEngine(
            WalletModel(
              address: EthereumAddress.fromHex(address),
              username: username,
              securityPassword: Uint8List(0),
              dateCreated: DateTime.now(),
              isFavorite: i < 2 ? true : false,
            ),
          );

      result[address] = engine;
      yield engine;
    }

    engines = result;
  }

  @override
  int count() => _wallets.length;

  @override
  Future<bool> addNew({
    required String username,
    required String password,
    required String securityPassword,
  }) async {
    if (_wallets[username] == null) {
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
      _wallets[username] = wallet.address!.hexEip55;
      return true;
    }

    return false;
  }

  @override
  Future<bool> loginValidate({
    required String address,
    required String password,
  }) async {
    return password == '123';
  }

  @override
  Future<bool> login({
    required String address,
    required String password,
    required String otpCode,
  }) async {
    return true;
  }

  @override
  Future<void> setFavorite(String address) async {
    final WalletEngine engine = engines[address]!;
    engine.wallet.isFavorite = !engine.isFavorite();
  }
}
