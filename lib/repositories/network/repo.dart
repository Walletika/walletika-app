import 'package:walletika_sdk/walletika_sdk.dart';

abstract class NetworkRepository {
  Stream<NetworkModel> getAll();

  Future<bool> addNew({
    required String rpc,
    required String name,
    required int chainID,
    required String symbol,
    required String explorer,
  });

  Future<bool> remove(NetworkModel network);
}
