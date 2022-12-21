import 'package:walletika_api/walletika_api.dart';

import '../../models/network.dart';
import 'repo.dart';

class NetworkFakeRepository extends NetworkRepository {
  final List<NetworkItemModel> _networks = [
    NetworkItemModel(
      imageURL:
          'https://assets.coingecko.com/coins/images/279/small/ethereum.png?1595348880',
      name: 'Ethereum',
      rpc: 'https://mainnet.infura.io/v3/9aa3d95b3bc440fa88ea12eaa4456161',
      chainID: 1,
      symbol: 'ETH',
      explorer: '',
      isLocked: true,
    ),
    NetworkItemModel(
      imageURL:
          'https://assets.coingecko.com/coins/images/279/small/ethereum.png?1595348880',
      name: 'Goerli Ethereum ( Testnet )',
      rpc: 'https://goerli.infura.io/v3/',
      chainID: 1,
      symbol: 'ETH',
      explorer: '',
      isLocked: false,
    ),
    NetworkItemModel(
      imageURL:
          'https://assets.coingecko.com/coins/images/825/small/bnb-icon2_2x.png?1644979850',
      name: 'Binance Smart Chain',
      rpc: 'https://bsc-dataseed1.binance.org',
      chainID: 1,
      symbol: 'BNB',
      explorer: '',
      isLocked: false,
    ),
    NetworkItemModel(
      imageURL:
          'https://assets.coingecko.com/coins/images/825/small/bnb-icon2_2x.png?1644979850',
      name: 'Binance Smart Chain ( Testnet )',
      rpc: 'https://data-seed-prebsc-1-s1.binance.org:8545',
      chainID: 1,
      symbol: 'BNB',
      explorer: '',
      isLocked: false,
    ),
    NetworkItemModel(
      imageURL:
          'https://assets.coingecko.com/coins/images/4713/small/matic-token-icon.png?1624446912',
      name: 'Polygon',
      rpc: 'https://polygon-mainnet.infura.io',
      chainID: 1,
      symbol: 'MATIC',
      explorer: '',
      isLocked: false,
    ),
  ];

  @override
  Future<List<NetworkItemModel>> getAll(bool mainnetOnly) async {
    return [
      for (final NetworkItemModel network in _networks)
        if (!mainnetOnly || !network.name.toLowerCase().contains('testnet'))
          network
    ];
  }

  @override
  Future<bool> addNew({
    required String rpc,
    required String name,
    required int chainID,
    required String symbol,
    required String explorer,
  }) async {
    _networks.add(
      NetworkItemModel(
        imageURL:
            await WalletikaAPI.getCoinImage(CoinEntry(symbol: symbol)).then(
          (coin) => coin.imageURL,
        ),
        name: name,
        rpc: rpc,
        chainID: chainID,
        symbol: symbol,
        explorer: explorer,
        isLocked: false,
      ),
    );
    return true;
  }

  @override
  Future<bool> remove(NetworkItemModel network) async {
    return _networks.remove(network);
  }
}
