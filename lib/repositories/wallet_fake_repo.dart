import 'dart:math';
import 'dart:typed_data';

import 'package:walletika_sdk/walletika_sdk.dart';
import 'package:web3dart/web3dart.dart';

import 'wallet_repo.dart';

class WalletFakeRepository extends WalletRepository {
  final List<String> _wallets = [];

  @override
  Future<List<WalletModel>> getAll() {
    return Future(() async {
      for (int i = 0; i < 100; i++) {
        var rng = Random.secure();
        EthPrivateKey credentials = EthPrivateKey.createRandom(rng);
        _wallets.add(credentials.address.hexEip55);
        await Future.delayed(const Duration(milliseconds: 10));
      }

      return [
        for (var i = 0; i < _wallets.length; i++)
          WalletModel(
            address: EthereumAddress.fromHex(_wallets[i]),
            username: 'Username $i',
            recoveryPassword: Uint8List(0),
            dateCreated: DateTime.now(),
            isFavorite: i <= 2 ? true : false,
          )
      ];
    });
  }
}
