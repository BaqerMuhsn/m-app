import 'package:flutter/material.dart';
import 'package:get/get.dart';

  // Adjust your imports
    import 'widgets/Recent_searches.dart';
    import 'widgets/Recommended_places.dart';
    import 'widgets/events_you_might_like.dart';
    import '../../../model/warning_type.dart';
    import 'widgets/warning_search.dart';

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

    // Obx replaces StreamBuilder
    return Obx(() {
      if (networkController.isConnected.value) {
        return Column(
          children: [
            const SizedBox(height: 100),
            Center(
              child: WarningSearch(warningType: warningTypes.first),
            ),
          ],
        );
      }
      
      return const Column(
        children: [
          RecentSearches(),
          RecommendedPlaces(),
          EventsYouMightLike(),
        ],
      );
    });
  }
}