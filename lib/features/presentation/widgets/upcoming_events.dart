import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UpcomingEvents extends StatefulWidget {
  final String title;
  final String seeAllLabel;
  final VoidCallback? onSeeAll;

  final List<UpcomingEvent> events;

  const UpcomingEvents({
    super.key,
    this.title = ' أبرز الفعاليات القادمة ',
    this.seeAllLabel = 'رؤية الجميع',
    this.onSeeAll,

    this.events = const [
      UpcomingEvent(
        title: '1تعلم أساسيات تصميم تجربة المستخدم',
        venue: 'المحطة',
        dateMonth: 'أذار',
        dateDay: '6',
        imageUrl: 'images/Rectangle2.png',
      ),
      UpcomingEvent(
        title: '2تعلم أساسيات تصميم تجربة المستخدم',
        venue: 'المحطة',
        dateMonth: 'أذار',
        dateDay: '6',
        imageUrl: 'images/Rectangle2.png',
      ),
      UpcomingEvent(
        title: '3تعلم أساسيات تصميم تجربة المستخدم',
        venue: 'المحطة',
        dateMonth: 'أذار',
        dateDay: '6',
        imageUrl: 'images/Rectangle2.png',
      ),
    ],
  });

  @override
  State<UpcomingEvents> createState() => _UpcomingEventsState();
}

class _UpcomingEventsState extends State<UpcomingEvents> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF102A43),
                ),
              ),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: widget.onSeeAll,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.seeAllLabel,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF78879A),
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
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
          height: 340,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            padding: const EdgeInsets.symmetric(vertical: 4),
            itemCount: widget.events.length,
            separatorBuilder: (_, __) => const SizedBox(width: 15),
            itemBuilder: (context, i) => SizedBox(
              width: 300,
              child: _EventCard(event: widget.events[i]),
            ),
          ),
        ),
      ],
    );
  }
}

class UpcomingEvent {
  final String title;
  final String venue;
  final String dateMonth;
  final String dateDay;
  final String? imageUrl;
  final String? venueLogoAsset;

  const UpcomingEvent({
    required this.title,
    required this.venue,
    required this.dateMonth,
    required this.dateDay,
    this.imageUrl,
    this.venueLogoAsset,
  });
}

class _EventCard extends StatelessWidget {
  final UpcomingEvent event;

  const _EventCard({required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(24)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              SizedBox(
                height: 200,
                width: double.infinity,
                child: event.imageUrl != null
                    ? Image.asset(event.imageUrl!, fit: BoxFit.cover)
                    : Container(color: const Color(0xFFE4E8EF)),
              ),
              
            ],
          ),
          Transform.translate(
            offset: const Offset(0, -24),
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 40,
                          child: Text(
                            event.title,
                            textAlign: TextAlign.start,
                            softWrap: true,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF102A43),
                            ),
                          ),
                        ),

                        const SizedBox(width: 4),

                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 80,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 22,
                                    height: 22,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    alignment: Alignment.center,
                                    child: SvgPicture.asset(
                                      'images/03_location-01.svg',
                                      width: 20,
                                      height: 20,
                                      colorFilter: ColorFilter.mode(
                                        const Color(0xFF0F73F7),
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    event.venue,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF78879A),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 80,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 22,
                                    height: 22,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    alignment: Alignment.center,
                                    child: SvgPicture.asset(
                                      'images/04_calendar-02.svg',
                                      width: 20,
                                      height: 20,
                                      colorFilter: ColorFilter.mode(
                                        const Color(0xFF0F73F7),
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                   '${event.dateDay} ${event.dateMonth}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF78879A),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
