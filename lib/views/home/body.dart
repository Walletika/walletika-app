import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import '../../controllers/wallet_manager.dart';
import '../../utils/constants.dart';
import '../widgets/address.dart';
import '../widgets/container.dart';

class HomeBody extends StatelessWidget {
  HomeBody({super.key});

  final WalletManagerController walletManagerController =
      Get.find<WalletManagerController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ContainerWithShadow(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: TextField(
                  onChanged: (value) {
                    walletManagerController.walletsUpdate(value);
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    label: Text("Search".tr),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Obx(() {
            if (walletManagerController.wallets.isEmpty) {
              if (walletManagerController.count == 0) {
                return Padding(
                  padding: const EdgeInsets.all(AppDecoration.padding),
                  child: Column(
                    children: [
                      Flexible(
                        flex: 8,
                        child: Image.asset(
                          AppImages.coinIllustrations,
                          filterQuality: FilterQuality.medium,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          "No wallets has been added yet!".tr,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          "Let's add your first wallet today, click on \"+\" button. It's easy."
                              .tr,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return const Center(child: CircularProgressIndicator());
            }

            return ListView(
              children: walletManagerController.wallets.map((wallet) {
                return ListTile(
                  onTap: () {},
                  leading: const Icon(
                    LineIcons.wallet,
                    size: 50.0,
                    color: AppColors.highlight,
                  ),
                  title: Text(
                    wallet.username,
                    softWrap: false,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  subtitle: TextAddress(wallet.address, height: 30.0),
                  trailing: Column(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Icon(
                          wallet.isFavorite ? Icons.star : Icons.star_border,
                          color: wallet.isFavorite ? Colors.orange : null,
                        ),
                      ),
                      Icon(
                        Icons.online_prediction,
                        color: wallet.isLogged ? Colors.green : null,
                      ),
                    ],
                  ),
                );
              }).toList(),
            );
          }),
        ),
      ],
    );
  }
}