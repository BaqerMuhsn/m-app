import 'package:get/get.dart';
import '../controllers/home_controllers.dart';
import '../../explore/bindings/explore_bindings.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    ExploreBinding().dependencies();
  }
}