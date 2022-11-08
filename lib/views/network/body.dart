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
import '../widgets/itemlogo.dart';
import '../widgets/snackbar.dart';

class NetworkBody extends StatelessWidget {
  NetworkBody({super.key});

  final SettingsController _settingsController = Get.find<SettingsController>();
  final NetworkManagerController _networkManagerController =
      Get.find<NetworkManagerController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header
        ContainerWithShadow(
          child: Column(
            children: [
              Text(
                "1000@network".tr,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              ListTile(
                title: Text("1002@network".tr),
                trailing: Obx(() {
                  return Switch.adaptive(
                    value: _settingsController.isTestnetHidden,
                    onChanged: (value) {
                      _settingsController
                          .testnetHiddenUpdate(value)
                          .then((value) {
                        _networkManagerController.networksUpdate();
                      });
                    },
                  );
                }),
              ),
            ],
          ),
        ),
        // List view
        Expanded(
          child: Obx(() {
            final String currentNetwork = _settingsController.currentNetwork;
            final List<NetworkItemModel> networks =
                _networkManagerController.networks;

            if (networks.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            return ListView.separated(
              separatorBuilder: (context, index) => const Divider(
                indent: AppDecoration.dividerPadding,
                endIndent: AppDecoration.dividerPadding,
              ),
              itemCount: networks.length,
              itemBuilder: (context, index) {
                final NetworkItemModel network = networks[index];

                return ListTile(
                  onTap: () => _settingsController.networkUpdate(network.name),
                  minVerticalPadding: 20.0,
                  leading: ItemLogo(
                    path: network.icon,
                    isActive: currentNetwork == network.name,
                  ),
                  title: Text(
                    network.symbol,
                    softWrap: false,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  subtitle: Text(network.name, softWrap: false),
                  trailing: network.isLocked
                      ? const SizedBox(
                          width: 40.0,
                          child: Icon(
                            LineIcons.lock,
                            size: AppDecoration.iconSmallSize,
                          ),
                        )
                      : IconButton(
                          onPressed: () {
                            awesomeDialog(
                              context: context,
                              dialogType: DialogType.warning,
                              title: "1003@network".tr,
                              desc: "${"1004@network".tr}\n${network.name}",
                              btnOkText: "1007@global".tr,
                              btnOkOnPress: () {
                                _networkManagerController
                                    .remove(network)
                                    .then((value) {
                                  modernSnackBar(
                                    context: context,
                                    title: "1003@network".tr,
                                    message:
                                        "${network.name} ${value ? "1005@network".tr : "1006@network".tr}",
                                    isSuccess: value,
                                  );
                                });
                              },
                            ).show();
                          },
                          icon: const Icon(
                            LineIcons.times,
                            size: AppDecoration.iconSmallSize,
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
}
