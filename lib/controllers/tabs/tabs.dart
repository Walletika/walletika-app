import 'package:get/get.dart';

class TabsController extends GetxController {
  TabsController(this.totalTabs);

  // States
  final RxInt _currentTabIndex = 0.obs;

  // Local Data
  final int totalTabs;

  // Getter methods
  int get currentTabIndex => _currentTabIndex.value;

  // Setter & Controller methods
  int setTabIndex(int index) {
    if (_currentTabIndex.value != index && index < totalTabs) {
      _currentTabIndex.value = index;
    }
    return _currentTabIndex.value;
  }

  int toNextTab() {
    if (_currentTabIndex.value < totalTabs - 1) _currentTabIndex.value++;
    return _currentTabIndex.value;
  }

  int toPreviousTab() {
    if (_currentTabIndex.value > 0) _currentTabIndex.value--;
    return _currentTabIndex.value;
  }
}
