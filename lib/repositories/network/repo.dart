import '../../models/network.dart';

abstract class NetworkRepository {
  Stream<NetworkItemModel> getAll();

  Future<bool> addNew({
    required String rpc,
    required String name,
    required int chainID,
    required String symbol,
    required String explorer,
  });

  Future<bool> remove(NetworkItemModel network);
}
