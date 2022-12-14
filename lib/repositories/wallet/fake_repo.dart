import 'dart:convert';

import 'package:walletika/models/token.dart';
import 'package:walletika_sdk/walletika_sdk.dart';

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

  final List<TokenItemModel> _tokens = [
    TokenItemModel(
      imageURL:
          'https://assets.coingecko.com/coins/images/279/small/ethereum.png?1595348880',
      name: 'Ethereum',
      address: '',
      symbol: 'ETH',
      changeIn24h: 0.02,
      price: 1252.790000102,
      balance: 15.65880001,
      balanceInFiat: 19617.180,
    ),
    TokenItemModel(
      imageURL:
          'https://assets.coingecko.com/coins/images/325/small/Tether.png?1668148663',
      name: 'Tether',
      address: '',
      symbol: 'USDT',
      changeIn24h: -0.01,
      price: 1.0,
      balance: 21100.000,
      balanceInFiat: 21100.0,
    ),
    TokenItemModel(
      imageURL:
          'https://assets.coingecko.com/coins/images/1/small/bitcoin.png?1547033579',
      name: 'Bitcoin',
      address: '',
      symbol: 'BTC',
      changeIn24h: 1.7,
      price: 17033.42,
      balance: 0.50000001,
      balanceInFiat: 8516.71,
    ),
    TokenItemModel(
      imageURL:
          'https://assets.coingecko.com/coins/images/11939/small/shiba.png?1622619446',
      name: 'Shiba Inu',
      address: '',
      symbol: 'SHIB',
      changeIn24h: -0.2,
      price: 0.00000889,
      balance: 10000000,
      balanceInFiat: 88.11,
    ),
  ];

  @override
  Stream<WalletViewModel> getAll() async* {
    for (final WalletViewModel wallet in _wallets) {
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
    final WalletGeneratorInfo? wallet = await walletGenerator(
      username: username,
      password: password,
      securityPassword: utf8.encoder.convert(securityPassword),
      createNew: true,
    );

    if (wallet != null) {
      _wallets.add(
        WalletViewModel(
          username: username,
          address: wallet.address.hexEip55,
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

  @override
  Future<List<TokenItemModel>> tokens(WalletViewModel currentWallet) async {
    return _tokens;
  }
}
