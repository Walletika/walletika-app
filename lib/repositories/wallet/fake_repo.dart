import 'dart:math';
import 'dart:typed_data';

import 'package:walletika_sdk/walletika_sdk.dart';
import 'package:web3dart/web3dart.dart';

import 'repo.dart';

class WalletFakeRepository extends WalletRepository {
  final Map<String, String> _wallets = {
    'Wallet 1': '0x6Aa0594dCDBb1567533Bb993EF3ef61291725141',
    'Wallet 2': '0x80A12649298e565600cE4Dd2497cdD749Cd0720d',
    'Wallet 3': '0xaD923b04b2B08D678668D09D9776968cE1811F66',
    // 'Wallet 4': '0xFE96aB9a007cdc6283566803d29C73e0F4CdF0cB',
    // 'Wallet 5': '0xeD3eD2E44CA62D0343B8780A2e13a7E707E1f422',
    // 'Wallet 6': '0xC7574ECB3265B4AB79431107a3dfB560a4b344b4',
    // 'Wallet 7': '0x39b960758c6473c5aA77D30FEBb7A29987bfB852',
    // 'Wallet 8': '0x5D3b75341d991e82877289A286F5071691f50e56',
    // 'Wallet 9': '0x80De2f41F2DBf2FA8e439F3f3C2dA9aA2759B5f6',
    // 'Wallet 10': '0x4F2558eEC33c04d2D0dDF96ee2b9faeb13B19dde',
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
              isFavorite: i <= 2 ? true : false,
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
    final EthPrivateKey credentials = EthPrivateKey.createRandom(
      Random.secure(),
    );
    if (_wallets[username] == null) {
      _wallets[username] = credentials.address.hexEip55;
      return true;
    }

    return false;
  }

  @override
  Future<bool> loginValidate({
    required String address,
    required String password,
  }) async {
    return password == '123456789';
  }

  @override
  Future<bool> login({
    required String address,
    required String password,
    required String otpCode,
  }) async {
    return password == '123456789' && otpCode == '123456';
  }

  @override
  Future<void> setFavorite(String address) async {
    final WalletEngine engine = engines[address]!;
    engine.wallet.isFavorite = !engine.isFavorite();
  }
}
