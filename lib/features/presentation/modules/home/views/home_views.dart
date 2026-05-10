import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

// Adjust these imports to match your actual project structure
  import 'widgets/Events.dart';
  import 'widgets/HallsAndWorkspaces.dart';
  import '../../../widgets/gradient_scaffold.dart';
  import 'widgets/upcoming_events.dart';
  import 'widgets/PopularPlaces.dart';
import '../../../widgets/custom_bottom_nav.dart';
import '../../search/views/search_view.dart';
import '../controllers/home_controllers.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  static const _switchDuration = Duration(milliseconds: 320);
  static const double _appBarHeight = 60;
  static const double _bottomBarScrollPadding = 96;

  @override
  Widget build(BuildContext context) {
    // Obx at the root because Scaffold properties (appBar, bottomNavigationBar) 
    // must be added or removed dynamically based on state.
    return Obx(() {
      final topInset = MediaQuery.of(context).padding.top;
      final bottomPad = MediaQuery.viewPaddingOf(context).bottom + _bottomBarScrollPadding;
      final appBarTop = controller.isSearchActive.value ? topInset : topInset + _appBarHeight;

      return GradientScaffold(
        appBar: controller.isSearchActive.value
            ? null
            : PreferredSize(
                preferredSize: const Size.fromHeight(_appBarHeight),
                child: AppBar(
                  // Listens to scroll state
                  backgroundColor: controller.isScrolled.value ? const Color(0xFFFFFFFF) : Colors.transparent,
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
                              style: TextStyle(fontSize: 12, color: Color(0xFF78879A), fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'حسين علي أسامة',
                              style: TextStyle(fontSize: 14, color: Color(0xFF102A43), fontWeight: FontWeight.w800),
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
        bottomNavigationBar: controller.isSearchActive.value ? null : const CustomBottomNav(),
        body: NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            final isVertical = notification.metrics.axis == Axis.vertical && notification.depth == 0;
            if (isVertical) {
              controller.onScroll(notification.metrics.pixels);
            }
            return false;
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(16, appBarTop, 16, bottomPad),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Container(
                          height: 48,
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(22),
                            border: Border.all(color: const Color(0xFFE4E8EF)),
                            boxShadow: const [
                              BoxShadow(color: Color(0x0F000000), blurRadius: 10, offset: Offset(0, 2)),
                            ],
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'images/07_search-01.svg',
                                width: 22,
                                height: 22,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: TextField(
                                  controller: controller.searchController,
                                  onTap: controller.enableSearch,
                                  textAlignVertical: TextAlignVertical.center,
                                  style: const TextStyle(fontSize: 14, color: Color(0xFF102A43)),
                                  decoration: const InputDecoration(
                                    isCollapsed: true,
                                    border: InputBorder.none,
                                    hintText: 'البحث',
                                    hintStyle: TextStyle(fontSize: 14, color: Color(0xFF9AA7B8)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    AnimatedSwitcher(
                      duration: _switchDuration,
                      child: controller.isSearchActive.value
                          ? Row(
                              key: const ValueKey('cancel'),
                              children: [
                                const SizedBox(width: 10),
                                TextButton(
                                  onPressed: controller.cancelSearch,
                                  child: const Text(
                                    'إلغاء',
                                    style: TextStyle(
                                      color: Color(0xFF7B8CA1),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox.shrink(key: ValueKey('no-cancel')),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
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
                      : const Column(
                          key: ValueKey('home-content'),
                          children: [
                            Events(),
                            UpcomingEvents(),
                            PopularPlaces(),
                            HallsAndWorkspaces(),
                          ],
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