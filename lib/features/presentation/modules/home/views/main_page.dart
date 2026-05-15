import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../widgets/custom_bottom_nav.dart';
import '../../../widgets/gradient_scaffold.dart';
import '../../explore/controllers/explore_controller.dart';
import '../../explore/views/explore_view.dart';
import '../../search/views/search_view.dart';
import '../controllers/home_controllers.dart';
import 'home_views.dart';

/// App shell page (app bar, search, bottom nav, and tab switching).
class MainPage extends GetView<HomeController> {
  const MainPage({super.key});

  static const _switchDuration = Duration(milliseconds: 320);
  static const double _appBarHeight = 60;
  static const double _bottomBarScrollPadding = 96;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final navIndex = controller.navIndex.value;
      final topInset = MediaQuery.of(context).padding.top;
      final bottomPad = MediaQuery.viewPaddingOf(context).bottom + _bottomBarScrollPadding;
      final appBarTop = controller.isSearchActive.value ? topInset : topInset + _appBarHeight;

      return GradientScaffold(
        appBar: controller.isSearchActive.value
            ? null
            : PreferredSize(
                preferredSize: const Size.fromHeight(_appBarHeight),
                child: AppBar(
                  backgroundColor:
                      controller.isScrolled.value ? const Color(0xFFFFFFFF) : Colors.transparent,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
                  ),
                  clipBehavior: Clip.antiAlias,
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  titleSpacing: 12,
                  title: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    child: Row(
                      children: [
                        const SizedBox(width: 8),
                        const CircleAvatar(
                          radius: 24,
                          backgroundImage: AssetImage('images/Avatar.png'),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text(
                              'أهلاً بك',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF78879A),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'حسين علي أسامة',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF102A43),
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.white,
                          child: SvgPicture.asset(
                            'images/05_notification-01.svg',
                            width: 24,
                            height: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
        bottomNavigationBar: controller.isSearchActive.value
            ? null
            : CustomBottomNav(
                activeIndex: navIndex,
                onTap: controller.setNavIndex,
              ),
        body: NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            final isVertical =
                notification.metrics.axis == Axis.vertical && notification.depth == 0;
            if (isVertical) {
              controller.onScroll(notification.metrics.pixels);
            }
            return false;
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(16, appBarTop, 16, bottomPad),
            child: Column(
              children: [
                AnimatedSwitcher(
                  duration: _switchDuration,
                  switchInCurve: Curves.easeOutCubic,
                  switchOutCurve: Curves.easeInCubic,
                  transitionBuilder: (child, animation) {
                    final slide = Tween<Offset>(
                      begin: const Offset(0.04, 0),
                      end: Offset.zero,
                    ).animate(animation);
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(position: slide, child: child),
                    );
                  },
                  child: controller.isSearchActive.value
                      ? const SearchContent()
                      : KeyedSubtree(
                          key: ValueKey(navIndex),
                          child: navIndex == 2
                              ? ExploreView(
                                  searchController: controller.searchController,
                                  showCancel: controller.isSearchActive.value,
                                  onCancel: controller.cancelSearch,
                                  places: Get.find<ExploreController>().places,
                                )
                              : const HomePage(),
                        ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
