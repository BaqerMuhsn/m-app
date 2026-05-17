import 'package:get/get.dart';

import '../controllers/hall_detail_controller.dart';

class HallDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HallDetailController());
  }
}
