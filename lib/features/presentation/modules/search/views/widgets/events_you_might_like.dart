import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../model/popular_models.dart';
import '../../controllers/search_controller.dart';
class EventsYouMightLike extends StatelessWidget {
  const EventsYouMightLike({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 30),
          const Align(
            alignment: Alignment.centerRight,
            child: Text(
              'فعاليات قد تعجبك',
              style: TextStyle(
                fontSize: 16 ,
                fontWeight: FontWeight.w900,
                color: Color(0xFF0D2342),
              ),
            ),
          ),
          const SizedBox(height: 18),
          ...SearchingController.events.map(
            (event) => Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: _EventYouMightLikeCard(event: event),
            ),
          ),
        ],
      ),
    );
  }
}



class _EventYouMightLikeCard extends StatelessWidget {
  final EventYouMightLike event;

  const _EventYouMightLikeCard({required this.event});

  @override
  Widget build(BuildContext context) {
    return 
      Container(
      width: 343,
      height: 150,
      decoration: BoxDecoration(
        color: const Color(0xFFF6F7FB),
        borderRadius: BorderRadius.circular(34),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Image.asset(
              event.imagePath,
              width: 120,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title,
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.25,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF0D2342),
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                     SvgPicture.asset(
                      'images/03_location-01.svg',
                      width: 23,
                      height: 23,
                      colorFilter: const ColorFilter.mode(
                        Color(0xFF0F73F7),
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 6),
                     Text(
                      event.venue,
                      style: const TextStyle(
                        fontSize: 12,
                        height: 1.1,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF7A8B9A),
                      ),
                    ),
                  
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                   SvgPicture.asset(
                      'images/04_calendar-02.svg',
                      width: 23,
                      height: 23,
                      colorFilter: const ColorFilter.mode(
                        Color(0xFF0F73F7),
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 6),
                      Text(
                      event.dateText,
                      style: const TextStyle(
                        fontSize: 12,
                        height: 1.1,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF7A8B9A),
                      ),
                    ),
                   
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
