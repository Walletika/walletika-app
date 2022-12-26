import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import '../../controllers/network/network.dart';
import '../../controllers/settings/settings.dart';
import '../../models/network.dart';
import '../../utils/constants.dart';
import '../widgets/container.dart';
import '../widgets/dialog.dart';
import '../widgets/item_logo.dart';
import '../widgets/operation_notifier.dart';
import '../widgets/spacer.dart';

class NetworkBody extends StatelessWidget {
  NetworkBody({super.key});

  final SettingsController _settingsController = Get.find<SettingsController>();
  final NetworkController _networkController = Get.find<NetworkController>();
  final OperationNotifier _testNetHiddenOperation = OperationNotifier(
    id: "0xEAB1b2Eb",
  );
  final OperationNotifier _networkTapOperation = OperationNotifier(
    id: "0xDB641091",
  );
  final OperationNotifier _removeOperation = OperationNotifier(
    id: "0xf6A9FFe9",
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ContainerWithShadow(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDecoration.paddingMedium,
            vertical: AppDecoration.padding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "1000@network".tr,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      "1002@network".tr,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  Obx(() {
                    return Switch.adaptive(
                      value: _settingsController.isTestnetHidden,
                      onChanged: _testNetHideOnChanged,
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: Obx(() {
            final String currentNetwork = _settingsController.currentNetwork;
            final List<NetworkItemModel> networks = _networkController.networks;

            if (networks.isEmpty) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }

            return ListView.separated(
              padding: const EdgeInsets.only(bottom: AppDecoration.spaceLarge),
              separatorBuilder: (context, index) => const Divider(
                indent: AppDecoration.dividerPadding,
                endIndent: AppDecoration.dividerPadding,
              ),
              itemCount: networks.length,
              itemBuilder: (context, index) {
                final NetworkItemModel network = networks[index];

                return ListTile(
                  onTap: () => _networkOnTap(network),
                  minVerticalPadding: 20.0,
                  leading: ItemLogo(imageURL: network.imageURL),
                  title: Row(
                    children: [
                      Flexible(
                        child: SizedBox(
                          height: 22.0,
                          child: Text(
                            network.name,
                            softWrap: false,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                      ),
                      ...currentNetwork == network.name
                          ? [
                              horizontalSpace(),
                              const Icon(
                                Icons.check_rounded,
                                size: AppDecoration.iconSmallSize,
                                color: AppColors.green,
                              ),
                            ]
                          : [],
                    ],
                  ),
                  subtitle: Text(
                    network.rpc,
                    softWrap: false,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  trailing: IconButton(
                    tooltip:
                        network.isLocked ? "1007@network".tr : "1007@global".tr,
                    onPressed: network.isLocked
                        ? null
                        : () => _removeOnPressed(network),
                    icon: Icon(
                      network.isLocked ? LineIcons.lock : LineIcons.times,
                      size: AppDecoration.iconSmallSize,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                );
              },
            );
          }),
        ),
      ],
    );
  }

  void _testNetHideOnChanged(bool enabled) {
    _testNetHiddenOperation.run(
      callback: () => _settingsController.testnetHiddenUpdate(enabled).then(
            (_) => true,
          ),
      onValid: _networkController.networksUpdate,
    );
  }

  void _networkOnTap(NetworkItemModel network) {
    _networkTapOperation.run(
      callback: () => _settingsController.networkUpdate(network.name).then(
            (_) => true,
          ),
    );
  }

  void _removeOnPressed(NetworkItemModel network) {
    awesomeDialog(
      dialogType: DialogType.warning,
      title: "1003@network".tr,
      desc: "${"1004@network".tr} ( ${network.name} )",
      btnOkText: "1007@global".tr,
      btnOkOnPress: () => _removeNetwork(network),
    ).show();
  }

  void _removeNetwork(NetworkItemModel network) {
    _removeOperation.run(
      callback: () => _networkController.remove(network),
      title: network.name,
      validMessage: "1005@network".tr,
      invalidMessage: "1006@network".tr,
    );
  }
}
