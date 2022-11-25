import 'package:get/get.dart';

class TabsController extends GetxController {
  // States
  final RxInt _currentTabIndex = 0.obs;

  // Local Data
  static const int totalTabs = 4;

  // Getter methods
  int get currentTabIndex => _currentTabIndex.value;

  // Setter & Controller methods
  int toNextTab() {
    if (_currentTabIndex.value < totalTabs - 1) _currentTabIndex.value++;
    return _currentTabIndex.value;
  }

  int toPreviousTab() {
    if (_currentTabIndex.value > 0) _currentTabIndex.value--;
    return _currentTabIndex.value;
  }
}
