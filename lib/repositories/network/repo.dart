import 'package:walletika_sdk/walletika_sdk.dart';

abstract class NetworkRepository {
  Stream<NetworkModel> getAll();

  Future<bool> remove(NetworkModel network);
}
