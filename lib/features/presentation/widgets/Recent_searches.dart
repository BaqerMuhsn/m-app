import 'package:flutter/material.dart';
import '../modules/search/controllers/search_controller.dart';


/// Recent search UI with built-in sample data (same idea as [RecommendedPlaces]).
class RecentSearches extends StatelessWidget {
  const RecentSearches({super.key});




  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'عمليات البحث الأخيرة',
              style: TextStyle(
                color: Color(0xFF102A43),
                fontSize: 16,
                fontWeight: FontWeight.w900,
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {},
              child: const Text('مسح الجميع' , style: TextStyle(
                color: Color(0xFF7B8CA1),
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: SearchingController.recentSearches
              .map((item) => _SearchTag(text: item.text))
              .toList(),
        ),
      ],
    );
  }
}

class _SearchTag extends StatelessWidget {
  final String text;
  const _SearchTag({required this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xBFFFFFFF),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: const Color(0xFFDDE4EE)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.close, size: 14, color: Color(0xFF7B8CA1)),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              color: Color(0xFF74899B),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
