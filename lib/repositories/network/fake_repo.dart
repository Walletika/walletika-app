import '../../models/network.dart';
import '../../utils/constants.dart';
import 'repo.dart';

class NetworkFakeRepository extends NetworkRepository {
  final List<NetworkItemModel> _networks = [
    NetworkItemModel(
      icon: '${AppImages.coins}/eth.png',
      name: 'Ethereum',
      rpc: 'https://mainnet.infura.io/v3/9aa3d95b3bc440fa88ea12eaa4456161',
      chainID: 1,
      symbol: 'ETH',
      explorer: '',
      isLocked: true,
    ),
    NetworkItemModel(
      icon: '${AppImages.coins}/eth.png',
      name: 'Goerli Ethereum ( Testnet )',
      rpc: 'https://goerli.infura.io/v3/',
      chainID: 1,
      symbol: 'ETH',
      explorer: '',
      isLocked: false,
    ),
    NetworkItemModel(
      icon: '${AppImages.coins}/bnb.png',
      name: 'Binance Smart Chain',
      rpc: 'https://bsc-dataseed1.binance.org',
      chainID: 1,
      symbol: 'BNB',
      explorer: '',
      isLocked: false,
    ),
    NetworkItemModel(
      icon: '${AppImages.coins}/bnb.png',
      name: 'Binance Smart Chain ( Testnet )',
      rpc: 'https://data-seed-prebsc-1-s1.binance.org:8545',
      chainID: 1,
      symbol: 'BNB',
      explorer: '',
      isLocked: false,
    ),
    NetworkItemModel(
      icon: '${AppImages.coins}/matic.png',
      name: 'Polygon',
      rpc: 'https://polygon-mainnet.infura.io',
      chainID: 1,
      symbol: 'MATIC',
      explorer: '',
      isLocked: false,
    ),
  ];

  @override
  Stream<NetworkItemModel> getAll() async* {
    for (final NetworkItemModel network in _networks) {
      yield network;
    }
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
        icon: '${AppImages.coins}/${symbol.toLowerCase()}.png',
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
