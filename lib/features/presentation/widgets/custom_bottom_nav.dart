import 'package:flutter/material.dart';

class CustomBottomNav extends StatelessWidget {
  final int activeIndex;
  final ValueChanged<int>? onTap;
  /// Top outer radius of the bar shell.
  final double topCornerRadius;

  const CustomBottomNav({
    super.key,
    this.activeIndex = 0,
    this.onTap,
    this.topCornerRadius = 24,
  });

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewPaddingOf(context).bottom;
    final items = <_NavItem>[
      const _NavItem(label: 'الرئيسية', icon: Icons.home_rounded),
      const _NavItem(label: 'تذاكر', icon: Icons.confirmation_num_outlined),
      const _NavItem(label: 'استكشاف', icon: Icons.explore_outlined),
      const _NavItem(label: 'الأماكن', icon: Icons.location_on_outlined),
      const _NavItem(label: 'المواعيد', icon: Icons.calendar_today_outlined),
    ];

    // Full width; shell extends to the bottom of the screen (under home indicator).
    // Row is padded so controls sit above the inset; background still fills to edge.
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(topCornerRadius),
        ),
      ),
      child: Material(
        type: MaterialType.transparency,
        color: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
        child: Padding(
          padding: EdgeInsets.fromLTRB(32, 14, 32, bottomInset),
          child: Row(
            children: List.generate(items.length, (index) {
                final item = items[index];
                final isActive = index == activeIndex;
                if (isActive) {
                  return Expanded(
                    flex: 2,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(30),
                      onTap: () => onTap?.call(index),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: const LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [Color(0xFF4B9CFF), Color(0xFF0F73F7)],
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(item.icon, color: Colors.white, size: 24),
                              const SizedBox(width: 8),
                              Text(
                                item.label,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }

                return Expanded(
                  child: InkWell(
                    onTap: () => onTap?.call(index),
                    customBorder: const CircleBorder(),
                    child: Tooltip(
                      message: item.label,
                      child: Icon(
                        item.icon,
                        color: const Color(0xFF7F919F),
                        size: 28,
                      ),
                    ),
                  ),
                );
              }),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final String label;
  final IconData icon;
  
  const _NavItem({required this.label, required this.icon});
}
