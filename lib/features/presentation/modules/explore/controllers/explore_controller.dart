import 'package:get/get.dart';

import '../../../model/popular_models.dart';
import '../../home/controllers/home_controllers.dart';

class ExploreController extends GetxController {
  /// Reuse the same places data shown on Home.
  List<PopularPlace> get places => Get.find<HomeController>().popularPlaces;
}
