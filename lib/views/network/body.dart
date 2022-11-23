import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import '../../controllers/network/network_manager.dart';
import '../../controllers/settings/settings.dart';
import '../../models/network.dart';
import '../../utils/constants.dart';
import '../widgets/container.dart';
import '../widgets/dialog.dart';
import '../widgets/item_logo.dart';
import '../widgets/operation_notifier.dart';

class NetworkBody extends StatelessWidget {
  NetworkBody({super.key});

  final SettingsController _settingsController = Get.find<SettingsController>();
  final NetworkManagerController _networkManagerController =
      Get.find<NetworkManagerController>();

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
                      onChanged: _onTestNetHideChanged,
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
            final List<NetworkItemModel> networks =
                _networkManagerController.networks;

            if (networks.isEmpty) {
              return const Center(child: CircularProgressIndicator());
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
                  onTap: () => _onItemTap(network),
                  minVerticalPadding: 20.0,
                  leading: ItemLogo(
                    path: network.icon,
                    isActive: currentNetwork == network.name,
                  ),
                  title: Text(
                    network.symbol,
                    softWrap: false,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  subtitle: Text(
                    network.name,
                    softWrap: false,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  trailing: IconButton(
                    tooltip:
                        network.isLocked ? "1007@network".tr : "1007@global".tr,
                    onPressed:
                        network.isLocked ? null : () => _onRemove(network),
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

  void _onTestNetHideChanged(bool enabled) {
    final OperationNotifier operation = OperationNotifier(
      title: "0xEAB1b2Eb",
    );

    _settingsController.testnetHiddenUpdate(enabled).then((_) {
      _networkManagerController.networksUpdate();
    }).catchError((error) {
      operation.error(error.toString());
      operation.notify();
    });
  }

  void _onItemTap(NetworkItemModel network) {
    final OperationNotifier operation = OperationNotifier(
      title: "0xDB641091",
    );

    _settingsController.networkUpdate(network.name).catchError((error) {
      operation.error(error.toString());
      operation.notify();
    });
  }

  void _onRemove(NetworkItemModel network) {
    awesomeDialog(
      context: Get.context!,
      dialogType: DialogType.warning,
      title: "1003@network".tr,
      desc: "${"1004@network".tr}\n${network.name}",
      btnOkText: "1007@global".tr,
      btnOkOnPress: () {
        final OperationNotifier operation = OperationNotifier(
          title: "1003@network".tr,
        );

        _networkManagerController.remove(network).then((isValid) {
          isValid
              ? operation.valid("${network.name} ${"1005@network".tr}")
              : operation.invalid("1006@network".tr);
          operation.notify();
        }).catchError((error) {
          operation.error(error.toString());
          operation.notify(title: "0xf6A9FFe9");
        });
      },
    ).show();
  }
}
