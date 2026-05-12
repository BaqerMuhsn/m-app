import 'package:flutter/material.dart';

import '../../../widgets/search_bar.dart';
import '../../../model/popular_models.dart';
import 'widgets/explore_place_card.dart';
import 'widgets/explore_filter_sheet.dart';

/// UI-only Explore page body (title + filter + search + vertical cards).
class ExploreView extends StatelessWidget {
  const ExploreView({
    super.key,
    required this.searchController,
    required this.showCancel,
    required this.onSearchTap,
    required this.onCancel,
    required this.places,
    this.onFilterTap,
  });

  final TextEditingController searchController;
  final bool showCancel;
  final VoidCallback onSearchTap;
  final VoidCallback onCancel;
  final VoidCallback? onFilterTap;
  final List<PopularPlace> places;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 10),
          const Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              'أستكشاف الأماكن',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: Color(0xFF102A43),
              ),
            ),
          ),
          SizedBox(
            height: 55,
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: HomeSearchBar(
                    textController: searchController,
                    showCancel: showCancel,
                    onFieldTap: onSearchTap,
                    onCancel: onCancel,
                  ),
                ),
                const SizedBox(width: 10),
                Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: onFilterTap ?? () => ExploreFilterSheet.show(context),
                    child: Container(
                      width: 48,
                      height: 48,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFFE4E8EF)),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x0F000000),
                            blurRadius: 10,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.tune_rounded,
                        color: Color(0xFF7F919F),
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          for (var i = 0; i < places.length; i++) ...[
            if (i > 0) const SizedBox(height: 16),
            SizedBox(
              height: 240,
              width: 320,
              child: ExplorePlaceCard(place: places[i]),
            ),
          ],
        ],
      ),
    );
  }
}
