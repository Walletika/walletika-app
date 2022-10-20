import 'package:get/get.dart';

import '../repositories/wallet_fake_repo.dart';
import '../repositories/wallet_repo.dart';

class WalletManagerController extends GetxController {
  // Data repository
  final WalletRepository _repository = WalletFakeRepository();
}
