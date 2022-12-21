import 'dart:convert';

import 'package:walletika_sdk/walletika_sdk.dart';

import '../../models/token.dart';
import '../../models/transaction.dart';
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
  Future<String?> getPrivateKey(String otpCode) async {
    if (otpCode == '123456') {
      return '0x78db9d2cb8c82cbc30bdcb8bab00c3ebedf88332cf6e85f543d295843754386f';
    }

    return null;
  }

  @override
  Future<void> setFavorite(WalletViewModel currentWallet) async {
    currentWallet.isFavorite = !currentWallet.isFavorite;
  }

  @override
  Future<List<TokenItemModel>> tokens(WalletViewModel currentWallet) async {
    return _tokens.map((token) => token).toList();
  }

  @override
  Future<void> addToken(TokenItemModel token) async {
    _tokens.add(token);
  }

  @override
  Future<bool> removeToken(TokenItemModel token) async {
    return _tokens.remove(token);
  }

  @override
  Future<List<TransactionItemModel>> transactions(
    WalletViewModel currentWallet,
  ) async {
    return _transactions.map((transaction) => transaction).toList();
  }

  @override
  String explorerURL(String address) {
    return "https://etherscan.io/address/$address";
  }
}
