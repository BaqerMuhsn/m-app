import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Search pill + optional «إلغاء». UI only — pass [textController], flags, and callbacks from outside.
class HomeSearchBar extends StatelessWidget {
  HomeSearchBar({
    super.key,
    required this.textController,
    this.showCancel = false,
    this.onFieldTap,
    this.onCancel,
    this.switchDuration = const Duration(milliseconds: 320),
    this.hintText = 'البحث',
    this.searchIconAsset = 'images/07_search-01.svg',
  });

  final TextEditingController textController;
  final bool showCancel;
  final VoidCallback? onFieldTap;
  final VoidCallback? onCancel;
  final Duration switchDuration;
  final String hintText;
  final String searchIconAsset;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: const Color(0xFFE4E8EF)),
                boxShadow: const [
                ],
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    searchIconAsset,
                    width: 22,
                    height: 22,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      
                      controller: textController,
                      onTap: onFieldTap,
                      textAlignVertical: TextAlignVertical.center,
                      style: const TextStyle(fontSize: 14, color: Color(0xFF102A43)),
                      decoration: InputDecoration(
                        isCollapsed: true,
                        border: InputBorder.none,
                        hintText: hintText,
                        hintStyle: const TextStyle(fontSize: 14, color: Color(0xFF9AA7B8)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        AnimatedSwitcher(
          duration: switchDuration,
          child: showCancel
              ? Row(
                  key: const ValueKey('cancel'),
                  children: [
                    const SizedBox(width: 10),
                    TextButton(
                      onPressed: onCancel ,
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
    );
  }
}
