import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:login_app/features/presentation/widgets/Events.dart';
import 'package:login_app/features/presentation/widgets/HallsAndWorkspaces.dart';
import 'package:login_app/features/presentation/widgets/gradient_scaffold.dart';
import 'package:login_app/features/presentation/widgets/upcoming_events.dart';
import 'package:login_app/features/presentation/widgets/PopularPlaces.dart';
import 'package:login_app/features/presentation/widgets/custom_bottom_nav.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isScrolled = false;

  static const double _appBarHeight = 60;

  void _onScroll(double offset) {
    final value = offset > 4;
    if (value != _isScrolled) {
      setState(() {
        _isScrolled = value;
      });
    }
  }

  static const double _bottomBarScrollPadding = 96;

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.of(context).padding.top;
    final bottomPad =
        MediaQuery.viewPaddingOf(context).bottom + _bottomBarScrollPadding;

    return GradientScaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(_appBarHeight),
        child: AppBar(
          backgroundColor: _isScrolled ? Color(0xFFFFFFFF) : Colors.transparent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
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
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
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
      bottomNavigationBar: const CustomBottomNav(),
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          final isVertical =
              notification.metrics.axis == Axis.vertical &&
              notification.depth == 0;
          if (isVertical) {
            _onScroll(notification.metrics.pixels);
          }
          return false;
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            16,
            topInset + _appBarHeight,
            16,
            bottomPad,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: const Color(0xFFE4E8EF)),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x0F000000),
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    ),
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
                        textAlignVertical: TextAlignVertical.center,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF102A43),
                        ),
                        decoration: const InputDecoration(
                          isCollapsed: true,
                          border: InputBorder.none,
                          hintText: 'البحث',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF9AA7B8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Events(),
              const UpcomingEvents(),
              const PopularPlaces(),
              
              const HallsAndWorkspaces(),
            ],
          ),
        ),
      ),
    );
  }
}
