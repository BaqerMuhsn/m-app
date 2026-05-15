import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home/controllers/home_controllers.dart';

  // Adjust your imports
    import 'widgets/Recent_searches.dart';
    import 'widgets/Recommended_places.dart';
    import 'widgets/events_you_might_like.dart';
    import '../../../model/warning_type.dart';
    import 'widgets/warning_search.dart';
    import '../../../widgets/search_bar.dart';
// Import the new NetworkController
    import '../../../../../core/controllers/network_controller.dart'; 

class SearchContent extends StatelessWidget {
  const SearchContent({super.key});
 
  static const List<WarningType> warningTypes = [
    WarningType(
      title: 'اتصال الإنترنت مفقود', 
      description: 'يبدو أنك غير متصل بالإنترنت. تحقق من اتصالك وحاول مرة أخرى.', 
      imagePath: 'images/Illustrations.svg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Initialize the controller. 
    // Get.put ensures it starts listening to the stream as soon as this widget loads.
    final NetworkController networkController = Get.put(NetworkController());

    final home = Get.find<HomeController>();

    return Obx(() {
      final connected = !networkController.isConnected.value;

      return Column(
        children: [
          HomeSearchBar(
            textController: home.searchController,
            onCancel: home.cancelSearch,
            showCancel: true,
          ),
          const SizedBox(height: 20),
          if (!connected)
            Padding(
              padding: const EdgeInsets.only(top: 80),
              child: Center(
                child: WarningSearch(warningType: warningTypes.first),
              ),
            )
          else ...[
            const RecentSearches(),
            const RecommendedPlaces(),
            const EventsYouMightLike(),
          ],
        ],
      );
    });
  }
}