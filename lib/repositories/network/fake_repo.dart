import '../../models/network.dart';
import '../../utils/constants.dart';
import 'repo.dart';

class NetworkFakeRepository extends NetworkRepository {
  final List<NetworkItemModel> _networks = [
    NetworkItemModel(
      icon: '${AppImages.coins}/eth.png',
      name: 'Ethereum',
      rpc: '',
      chainID: 1,
      symbol: 'ETH',
      explorer: '',
      isLocked: true,
    ),
    NetworkItemModel(
      icon: '${AppImages.coins}/eth.png',
      name: 'Ethereum ( Testnet )',
      rpc: '',
      chainID: 1,
      symbol: 'ETH',
      explorer: '',
      isLocked: false,
    ),
    NetworkItemModel(
      icon: '${AppImages.coins}/bnb.png',
      name: 'Binance Smart Chain',
      rpc: '',
      chainID: 1,
      symbol: 'BNB',
      explorer: '',
      isLocked: false,
    ),
    NetworkItemModel(
      icon: '${AppImages.coins}/bnb.png',
      name: 'Binance Smart Chain ( Testnet )',
      rpc: '',
      chainID: 1,
      symbol: 'BNB',
      explorer: '',
      isLocked: false,
    ),
    NetworkItemModel(
      icon: '${AppImages.coins}/matic.png',
      name: 'Polygon',
      rpc: '',
      chainID: 1,
      symbol: 'MATIC',
      explorer: '',
      isLocked: false,
    ),
  ];

  @override
  Stream<NetworkItemModel> getAll() async* {
    for (NetworkItemModel network in _networks) {
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
