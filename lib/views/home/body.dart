import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import '../../controllers/wallet/wallet_manager.dart';
import '../../models/wallet.dart';
import '../../utils/constants.dart';
import '../widgets/container.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/empty_page.dart';
import '../widgets/wallet_item.dart';

class HomeBody extends StatelessWidget {
  HomeBody({super.key}) {
    _searchInputController.addListener(_searchOnChanged);
  }

  final TextEditingController _searchInputController = TextEditingController();
  final WalletManagerController _walletManagerController =
      Get.find<WalletManagerController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search input
        ContainerWithShadow(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDecoration.paddingMedium,
            vertical: AppDecoration.padding,
          ),
          child: CustomTextFormField(
            controller: _searchInputController,
            placeholderText: "1005@global".tr,
            prefixIcon: const Icon(LineIcons.search),
            keyboardType: TextInputType.name,
          ),
        ),
        // List view
        Expanded(
          child: Obx(() {
            // No data view
            if (_walletManagerController.wallets.isEmpty) {
              if (_walletManagerController.count() == 0) {
                return EmptyPage(
                  illustrationPath: AppImages.coinIllustrations,
                  title: "1001@home".tr,
                  desc: "1002@home".tr,
                );
              }

              return const Center(child: CircularProgressIndicator());
            }

            final List<WalletItemModel> wallets =
                _walletManagerController.wallets;

            // Data view
            return ListView.separated(
              separatorBuilder: (context, index) => const Divider(
                indent: AppDecoration.dividerPadding,
                endIndent: AppDecoration.dividerPadding,
              ),
              itemCount: wallets.length,
              itemBuilder: (context, index) {
                final WalletItemModel wallet = wallets[index];

                return WalletItem(
                  onTap: () {},
                  username: wallet.username,
                  address: wallet.address,
                  isActive: wallet.isLogged,
                  trailing: IconButton(
                    tooltip: "1008@global".tr,
                    onPressed: () {
                      _walletManagerController.setFavorite(
                        search: _searchInputController.text,
                        address: wallet.address,
                      );
                    },
                    icon: Icon(
                      wallet.isFavorite ? LineIcons.starAlt : LineIcons.star,
                      color: wallet.isFavorite ? Colors.orange : null,
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

  void _searchOnChanged() {
    final String text = _searchInputController.text;
    _walletManagerController.walletsUpdate(text);
  }
}
