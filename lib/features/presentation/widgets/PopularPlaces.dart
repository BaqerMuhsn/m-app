import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../model/popular_models.dart';
import '../modules/home/controllers/home_controllers.dart';
class PopularPlaces extends StatelessWidget {
  final String title;
  final String seeAllLabel;
  final VoidCallback? onSeeAll;

  const PopularPlaces({
    super.key,
    this.title = 'الأماكن الشهرية',
    this.seeAllLabel = 'رؤية الجميع',
    this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF102A43),
                ),
              ),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: onSeeAll,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                child: Row(
                  children: const [
                    Text(
                      'رؤية الجميع',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF78879A),
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.chevron_right_rounded,
                      size: 18,
                      color: Color(0xFF78879A),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 250,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            itemCount: controller.popularPlaces.length,
            separatorBuilder: (_, __) => const SizedBox(width: 15),
            itemBuilder: (context, i) => SizedBox(
              width: 350,
              child: _PopularPlaceCard(place: controller.popularPlaces[i] as PopularPlace),
              
            ),
          ),
        ),
      const SizedBox(height: 40),],
    );
  }
}



class _PopularPlaceCard extends StatelessWidget {
  final PopularPlace place;

  const _PopularPlaceCard({required this.place});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(34),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(place.imagePath, fit: BoxFit.cover),
          Positioned(
            top: 18,
            right: 18,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: const Color.fromARGB(84, 255, 255, 255),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x1F000000),
                    blurRadius: 12,
                    offset: Offset(0, 2),
                  ),
                ],
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        'images/03_location-01.svg',
                        width: 18,
                        height: 18,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    place.locationLabel,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(14, 16, 14, 14),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0x00000000), Color(0xA6000000)],
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                       
                        const SizedBox(height: 5),

                        Row(
                          children: [
                            Container(
                              width: 64,
                              height: 64,
                              decoration: const BoxDecoration(
                                color: Color(0xFFF2F3F5),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Image.asset(
                                place.logoPath,
                                width: 100,
                                height: 100,
                              )),
                            ),
                            
                            const SizedBox(width: 6),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  place.name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                            Row(children: [
                              _StatChip(
                                text: place.rating,
                                icon: Icons.star_border_rounded,
                              ),
                              const SizedBox(width: 2),
                              _StatChip(
                                text: place.halls,
                                icon: Icons.meeting_room_outlined,
                              ),
                              const SizedBox(width: 2),
                              _StatChip(
                                text: place.events,
                                icon: Icons.handyman_outlined,
                              ),
                            ]),
                            
                          ],
                        ), ]),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
        ],
        

      ),
   
    );
    
  }
}

class _StatChip extends StatelessWidget {
  final String text;
  final IconData icon;

  const _StatChip({required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0x8A5C5C5C),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.white),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
          
        ],
        
      ),
     
    );
    
  }
}
