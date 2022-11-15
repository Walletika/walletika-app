import 'package:get/get.dart';
import 'package:walletika_sdk/walletika_sdk.dart';

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
    final List<NetworkItemModel> result = [];
    final String currentNetwork = _settingsController.currentNetwork;
    bool isCurrentNetworkAvailable = false;

    await for (NetworkModel network in _repository.getAll()) {
      if (_settingsController.isTestnetHidden &&
          network.name.toLowerCase().contains('testnet')) continue;

      if (!isCurrentNetworkAvailable && currentNetwork == network.name) {
        isCurrentNetworkAvailable = true;
      }

      result.add(
        NetworkItemModel(
          icon: 'assets/coins/${network.symbol.toLowerCase()}.png',
          rpc: network.rpc,
          symbol: network.symbol,
          name: network.name,
          chainID: network.chainID,
          explorer: network.explorer,
          isLocked: network.name == AppInfo.network,
        ),
      );
    }

    if (!isCurrentNetworkAvailable) {
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
    final bool result = await _repository.addNew(
      rpc: rpc,
      name: name,
      chainID: chainID,
      symbol: symbol,
      explorer: explorer,
    );
    await networksUpdate();

    return result;
  }

  Future<bool> remove(NetworkItemModel item) async {
    NetworkModel? networkModel;

    await for (NetworkModel network in _repository.getAll()) {
      if (item.name == network.name) {
        networkModel = network;
        break;
      }
    }

    if (networkModel is NetworkModel) {
      return await _repository.remove(networkModel).then((isValid) async {
        if (isValid) await networksUpdate();
        return isValid;
      });
    }

    return false;
  }
}
