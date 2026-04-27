import 'package:flutter/material.dart';

/// Thumbnails use PNG: these SVG files embed raster data; flutter_svg only handles vector paths well.
class RecommendedPlaces extends StatelessWidget {
  const RecommendedPlaces({super.key});

  static const List<Map<String, String>> recommendedPlaces = [
    {'name': 'المنصورة', 'image': 'images/computing_thumb.png'},
    {'name': 'المنصورة', 'image': 'images/mekars_thumb.png'},
    {'name': 'المنصورة', 'image': 'images/mekars_thumb.png'},
    {'name': 'المنصورة', 'image': 'images/computing_thumb.png'},
    {'name': 'المنصورة', 'image': 'images/mekars_thumb.png'},
    {'name': 'المنصورة', 'image': 'images/computing_thumb.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 30),
        const Text(
          'أماكن مقترحة',
          style: TextStyle(
            color: Color(0xFF102A43),
            fontSize: 16,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 96,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            itemCount: recommendedPlaces.length,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (context, i) {
              final place = recommendedPlaces[i];
              return _RecommendedPlaceTile(
                name: place['name']!,
                imagePath: place['image']!,
              );
            },
          ),
        ),
      ],
    );
  }
}

class _RecommendedPlaceTile extends StatelessWidget {
  final String name;
  final String imagePath;

  const _RecommendedPlaceTile({
    required this.name,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 65,
          height: 65,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Image.asset(
            imagePath,
            width: 65,
            height: 65,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF102A43),
          ),
        ),
      ],
    );
  }
}
