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
}
