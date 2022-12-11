import '../../models/network.dart';

abstract class NetworkRepository {
  Future<List<NetworkItemModel>> getAll(bool mainnetOnly);

  Future<bool> addNew({
    required String rpc,
    required String name,
    required int chainID,
    required String symbol,
    required String explorer,
  });

  Future<bool> remove(NetworkItemModel network);
}
