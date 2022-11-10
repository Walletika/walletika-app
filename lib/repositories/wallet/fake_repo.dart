import 'dart:typed_data';

import 'package:walletika_sdk/walletika_sdk.dart';
import 'package:web3dart/web3dart.dart';

import 'repo.dart';

class WalletFakeRepository extends WalletRepository {
  final List<String> _wallets = [
    '0x6Aa0594dCDBb1567533Bb993EF3ef61291725141',
    '0x80A12649298e565600cE4Dd2497cdD749Cd0720d',
    '0xaD923b04b2B08D678668D09D9776968cE1811F66',
    '0xFE96aB9a007cdc6283566803d29C73e0F4CdF0cB',
    '0xeD3eD2E44CA62D0343B8780A2e13a7E707E1f422',
    '0xC7574ECB3265B4AB79431107a3dfB560a4b344b4',
    '0x39b960758c6473c5aA77D30FEBb7A29987bfB852',
    '0x5D3b75341d991e82877289A286F5071691f50e56',
    '0x80De2f41F2DBf2FA8e439F3f3C2dA9aA2759B5f6',
    '0x4F2558eEC33c04d2D0dDF96ee2b9faeb13B19dde',
  ];

  @override
  Stream<WalletEngine> getAll() async* {
    final Map<String, WalletEngine> result = {};

    for (int i = 0; i < _wallets.length; i++) {
      final String address = _wallets[i];
      final WalletEngine engine = engines[address] ??
          WalletEngine(
            WalletModel(
              address: EthereumAddress.fromHex(address),
              username: 'Wallet $i',
              recoveryPassword: Uint8List(0),
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
  Future<void> setFavorite(String address) async {
    final WalletEngine engine = engines[address]!;
    engine.wallet.isFavorite = !engine.isFavorite();
  }
}
