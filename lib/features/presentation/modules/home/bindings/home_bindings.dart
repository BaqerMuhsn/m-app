import 'package:get/get.dart';

import '../../../../../core/controllers/network_controller.dart';
import '../../explore/bindings/explore_bindings.dart';
import '../controllers/home_controllers.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<NetworkController>(() => NetworkController(), fenix: true);
    ExploreBinding().dependencies();
  }
}
