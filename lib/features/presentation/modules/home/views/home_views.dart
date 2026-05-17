import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/search_bar.dart';
import '../controllers/home_controllers.dart';
import 'widgets/Events.dart';
import 'widgets/HallsAndWorkspaces.dart';
import 'widgets/PopularPlaces.dart';
import 'widgets/upcoming_events.dart';

/// Home tab content only (without app shell / navigation).
class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  static const _switchDuration = Duration(milliseconds: 320);

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey('home-content'),
      children: [
        HomeSearchBar(
          switchDuration: _switchDuration,
          textController: controller.searchController,
          onFieldTap: controller.openSearch,
          onCancel: controller.cancelSearch,
        ),
        const SizedBox(height: 20),
        const Events(),
        const UpcomingEvents(),
        const PopularPlaces(),
        const HallsAndWorkspaces(),
      ],
    );
  }
}