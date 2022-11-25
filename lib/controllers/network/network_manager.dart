import 'package:get/get.dart';

import '../../models/network.dart';
import '../../repositories/network/fake_repo.dart';
import '../../repositories/network/repo.dart';
import '../../utils/constants.dart';
import '../settings/settings.dart';

class NetworkManagerController extends GetxController {
  // Data repository
  final NetworkRepository _repository = NetworkFakeRepository();

  // States
  final RxList<NetworkItemModel> _networks = <NetworkItemModel>[].obs;

  // Local data
  final SettingsController _settingsController = Get.find<SettingsController>();

  // Event methods
  @override
  void onInit() async {
    await networksUpdate();
    super.onInit();
  }

  // Getter methods
  List<NetworkItemModel> get networks => _networks;

  bool networkExists({required String name, required String rpc}) =>
      _networks.any(
        (network) => network.name == name || network.rpc == rpc,
      );

  // Setter & Controller methods
  Future<void> networksUpdate() async {
    final List<NetworkItemModel> result = [
      await for (final NetworkItemModel network in _repository.getAll())
        if (!_settingsController.isTestnetHidden ||
            !network.name.toLowerCase().contains('testnet'))
          network
    ];

    if (!result.any(
      (network) => network.name == _settingsController.currentNetwork,
    )) {
      await _settingsController.networkUpdate(AppInfo.network);
    }

    _networks.value = result;
  }

  Future<bool> addNew({
    required String rpc,
    required String name,
    required int chainID,
    required String symbol,
    required String explorer,
  }) async {
    final bool isValid = await _repository.addNew(
      rpc: rpc,
      name: name,
      chainID: chainID,
      symbol: symbol,
      explorer: explorer,
    );

    if (isValid) await networksUpdate();

    return isValid;
  }

  Future<bool> remove(NetworkItemModel network) async {
    final bool isValid = await _repository.remove(network);

    if (isValid) await networksUpdate();

    return isValid;
  }
}
