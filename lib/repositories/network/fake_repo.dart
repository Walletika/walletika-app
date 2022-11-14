import 'package:walletika_sdk/walletika_sdk.dart';

import 'repo.dart';

class NetworkFakeRepository extends NetworkRepository {
  final List<List<String>> _networks = [
    ['Ethereum', 'ETH'],
    ['Ethereum ( Testnet )', 'ETH'],
    ['Binance Smart Chain', 'BNB'],
    ['Binance Smart Chain ( Testnet )', 'BNB'],
    ['Polygon', 'MATIC'],
    ['Polygon ( Testnet )', 'MATIC'],
  ];

  @override
  Stream<NetworkModel> getAll() async* {
    for (List<String> network in _networks) {
      yield NetworkModel(
        name: network[0],
        rpc: '',
        chainID: 0,
        symbol: network[1],
        explorer: '',
      );
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
    _networks.add([name, symbol]);
    return true;
  }

  @override
  Future<bool> remove(NetworkModel network) async {
    for (final List<String> i in _networks) {
      if (i[0] == network.name) {
        return _networks.remove(i);
      }
    }

    return false;
  }
}
