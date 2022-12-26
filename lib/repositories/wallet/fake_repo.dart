import 'dart:convert';

import 'package:walletika_sdk/walletika_sdk.dart';

import '../../models/token.dart';
import '../../models/transaction.dart';
import '../../models/wallet.dart';
import 'repo.dart';

class WalletFakeRepository extends WalletRepository {
  final List<WalletItemModel> _wallets = [
    WalletItemModel(
      username: 'Wallet1',
      address: '0x70463907F1aEe85619D8C248352d422681E304A1',
      dateCreated: DateTime.now(),
      isFavorite: true,
      isLogged: false,
    ),
    WalletItemModel(
      username: 'Wallet2',
      address: '0x81f4300AD8e46e2315A414DE387a23b84e9B8590',
      dateCreated: DateTime.now(),
      isFavorite: false,
      isLogged: false,
    ),
    WalletItemModel(
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
      explorerURL: "https://etherscan.io",
      name: 'Ethereum',
      symbol: 'ETH',
      changeIn24h: 0.02,
      price: 1252.790000102,
      balance: 15.65880001,
      balanceInFiat: 19617.180,
    ),
    TokenItemModel(
      imageURL:
          'https://assets.coingecko.com/coins/images/325/small/Tether.png?1668148663',
      explorerURL:
          "https://etherscan.io/token/0xdAC17F958D2ee523a2206206994597C13D831ec7",
      name: 'Tether',
      address: '0xdAC17F958D2ee523a2206206994597C13D831ec7',
      symbol: 'USDT',
      changeIn24h: -0.01,
      price: 1.0,
      balance: 21100.000,
      balanceInFiat: 21100.0,
      decimals: 6,
    ),
    TokenItemModel(
      imageURL:
          'https://assets.coingecko.com/coins/images/1/small/bitcoin.png?1547033579',
      explorerURL:
          "https://etherscan.io/token/0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599",
      name: 'Bitcoin',
      address: '0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599',
      symbol: 'BTC',
      changeIn24h: 1.7,
      price: 17033.42,
      balance: 0.50000001,
      balanceInFiat: 8516.71,
      decimals: 18,
    ),
    TokenItemModel(
      imageURL:
          'https://assets.coingecko.com/coins/images/11939/small/shiba.png?1622619446',
      explorerURL:
          "https://etherscan.io/token/0x95aD61b0a150d79219dCF64E1E6Cc01f0B64C4cE",
      name: 'Shiba Inu',
      address: '0x95aD61b0a150d79219dCF64E1E6Cc01f0B64C4cE',
      symbol: 'SHIB',
      changeIn24h: -0.2,
      price: 0.00000889,
      balance: 10000000,
      balanceInFiat: 88.11,
      decimals: 18,
    ),
  ];

  final List<TransactionItemModel> _transactions = [
    TransactionItemModel(
      txHash:
          '0x8bba8468ef5c5ba9cecbc78d2071569c5d7b5a2abe4c76c66850f66ff483130c',
      txHashURL:
          'https://ropsten.etherscan.io/tx/0x8bba8468ef5c5ba9cecbc78d2071569c5d7b5a2abe4c76c66850f66ff483130c',
      imageURL:
          'https://assets.coingecko.com/coins/images/279/small/ethereum.png?1595348880',
      functionName: 'transfer',
      date: DateTime.now(),
      symbol: 'ETH',
      amount: 0.132,
    ),
    TransactionItemModel(
      txHash:
          '0x5fe8e0956305179e16a7de319cbe376092327de763219dd7d3cd03178c8a2b0d',
      txHashURL:
          'https://ropsten.etherscan.io/tx/0x5fe8e0956305179e16a7de319cbe376092327de763219dd7d3cd03178c8a2b0d',
      imageURL:
          'https://assets.coingecko.com/coins/images/325/small/Tether.png?1668148663',
      functionName: 'transfer',
      date: DateTime.now(),
      symbol: 'USDT',
      amount: 5450.0,
    ),
  ];

  @override
  Stream<WalletItemModel> getAll() async* {
    for (final WalletItemModel wallet in _wallets) {
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
    if (username == 'error') throw Exception("Error");

    if (username == 'failed') return false;

    final WalletGeneratorInfo? wallet = await walletGenerator(
      username: username,
      password: password,
      securityPassword: utf8.encoder.convert(securityPassword),
      createNew: true,
    );

    if (wallet != null) {
      _wallets.add(
        WalletItemModel(
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
  Future<bool> remove(WalletItemModel wallet) async {
    if (wallet.username.contains('error')) throw Exception("Error");

    if (wallet.username.contains('failed')) return false;

    return _wallets.remove(wallet);
  }

  @override
  Future<bool> loginValidate({
    required WalletItemModel wallet,
    required String password,
  }) async {
    if (password == 'error') throw Exception("Error");

    if (password == 'failed') return false;

    return true;
  }

  @override
  Future<bool> login({
    required WalletItemModel wallet,
    required String password,
    required String otpCode,
  }) async {
    if (otpCode == '111111') throw Exception("Error");

    if (otpCode == '222222') return false;

    wallet.isLogged = true;
    return true;
  }

  @override
  Future<void> logout(WalletItemModel wallet) async {
    if (wallet.username.contains('error')) throw Exception("Error");

    wallet.isLogged = false;
  }

  @override
  Future<String?> getPrivateKey({
    required WalletItemModel wallet,
    required String otpCode,
  }) async {
    if (otpCode == '111111') throw Exception("Error");

    if (otpCode == '222222') return null;

    return '0x78db9d2cb8c82cbc30bdcb8bab00c3ebedf88332cf6e85f543d295843754386f';
  }

  @override
  Future<void> setFavorite(WalletItemModel wallet) async {
    if (wallet.username.contains('error')) throw Exception("Error");

    wallet.isFavorite = !wallet.isFavorite;
  }

  @override
  Future<List<TokenItemModel>> tokens(WalletItemModel wallet) async {
    return _tokens.map((token) => token).toList();
  }

  @override
  Future<void> addToken({
    required WalletItemModel wallet,
    required TokenItemModel token,
  }) async {
    if (wallet.username.contains('error')) throw Exception("Error");

    _tokens.add(token);
  }

  @override
  Future<bool> removeToken({
    required WalletItemModel wallet,
    required TokenItemModel token,
  }) async {
    if (wallet.username.contains('error')) throw Exception("Error");

    if (wallet.username.contains('failed')) return false;

    return _tokens.remove(token);
  }

  @override
  Future<List<TransactionItemModel>> transactions(
    WalletItemModel wallet,
  ) async {
    return _transactions.map((transaction) => transaction).toList();
  }

  @override
  Future<String> backup({
    required String directory,
    String? password,
    required void Function(int value) progressCallback,
  }) async {
    if (password != null && password.contains('error')) {
      throw Exception("Error");
    }

    for (int i = 0; i < 100; i++) {
      await Future.delayed(const Duration(milliseconds: 50));
      progressCallback(i);
    }

    return '$directory\\walletika.backup.aes';
  }

  @override
  Future<bool> import({
    required String path,
    String? password,
    required void Function(int value) progressCallback,
  }) async {
    if (password == 'error') throw Exception("Error");

    if (password == 'failed' || password == null) return false;

    for (int i = 0; i < 100; i++) {
      await Future.delayed(const Duration(milliseconds: 50));
      progressCallback(i);
    }

    return true;
  }

  @override
  String explorerURL(String address) {
    return "https://etherscan.io/address/$address";
  }
}
