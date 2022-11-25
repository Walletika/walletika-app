import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import '../../controllers/wallet/wallet.dart';
import '../../models/wallet.dart';
import '../../utils/constants.dart';
import '../widgets/container.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/empty_page.dart';
import '../widgets/operation_notifier.dart';
import '../widgets/wallet_item.dart';

class HomeBody extends StatelessWidget {
  HomeBody({super.key}) {
    _searchInputController.addListener(_searchOnChanged);
  }

  final TextEditingController _searchInputController = TextEditingController();
  final WalletController _walletController = Get.find<WalletController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ContainerWithShadow(
          padding: const EdgeInsets.only(
            left: AppDecoration.paddingMedium,
            right: AppDecoration.paddingMedium,
            bottom: AppDecoration.padding,
          ),
          child: CustomTextFormField(
            controller: _searchInputController,
            placeholderText: "1005@global".tr,
            prefixIcon: const Icon(LineIcons.search),
            keyboardType: TextInputType.name,
            inputFormatters: [
              FilteringTextInputFormatter.allow(AppRegExp.letters),
            ],
          ),
        ),
        Expanded(
          child: Obx(() {
            if (_walletController.wallets.isEmpty) {
              if (_walletController.count() == 0) {
                return EmptyPage(
                  illustrationPath: AppImages.coinIllustrations,
                  title: "1001@home".tr,
                  desc: "1002@home".tr,
                );
              }

              return const Center(child: CircularProgressIndicator());
            }

            final List<WalletViewModel> wallets = _walletController.wallets;

            return ListView.separated(
              padding: const EdgeInsets.only(bottom: AppDecoration.spaceLarge),
              separatorBuilder: (context, index) => const Divider(
                indent: AppDecoration.dividerPadding,
                endIndent: AppDecoration.dividerPadding,
              ),
              itemCount: wallets.length,
              itemBuilder: (context, index) {
                final WalletViewModel wallet = wallets[index];

                return WalletItem(
                  onTap: () {
                    _walletController.setCurrentWallet(wallet);
                    Get.toNamed(AppPages.login);
                  },
                  username: wallet.username,
                  address: wallet.address,
                  isActive: wallet.isLogged,
                  trailing: IconButton(
                    tooltip: "1008@global".tr,
                    onPressed: () => _onFavoritePressed(wallet),
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
    _walletController.walletsUpdate(text);
  }

  void _onFavoritePressed(WalletViewModel wallet) {
    final OperationNotifier operation = OperationNotifier(
      title: "0x2D23C079",
    );

    _walletController
        .setFavorite(
      search: _searchInputController.text,
      walletViewModel: wallet,
    )
        .catchError((error) {
      operation.error(error.toString());
      operation.notify();
    });
  }
}
