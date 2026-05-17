import 'package:get/get.dart';

import '../../../../../core/controllers/network_controller.dart';
import '../controllers/search_controller.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchingController>(() => SearchingController());
    if (!Get.isRegistered<NetworkController>()) {
      Get.lazyPut<NetworkController>(() => NetworkController(), fenix: true);
    }
  }
}