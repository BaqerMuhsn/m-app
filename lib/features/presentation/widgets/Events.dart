import 'package:flutter/material.dart';

class Events extends StatefulWidget {
  final String title;
  final String seeAllLabel;
  final VoidCallback? onSeeAll;
  final List<PopularCategory> categories;
  final List<PopularEvent> events;

  const Events({
    super.key,
    this.title = 'فعاليات هذا الأسبوع',
    this.seeAllLabel = 'رؤية الجميع',
    this.onSeeAll,
    this.categories = const [
      PopularCategory(label: 'الكل', icon: Icons.apps_rounded),
      PopularCategory(label: 'التصميم', icon: Icons.brush_rounded),
      PopularCategory(label: 'التقنية والبرمجة', icon: Icons.code_rounded),
      PopularCategory(label: 'التصميم', icon: Icons.brush_rounded),
      PopularCategory(label: 'التقنية والبرمجة', icon: Icons.code_rounded),
    ],
    this.events = const [
      PopularEvent(
        title: '1تعلم أساسيات تصميم تجربة المستخدم',
        venue: 'المحطة',
        dateMonth: 'أذار',
        dateDay: '6',
        imageUrl: 'images/Rectangle2.png',
        venueLogoAsset: 'images/logo.png',
      ),
      PopularEvent(
        title: '2تعلم أساسيات تصميم تجربة المستخدم',
        venue: 'المحطة',
        dateMonth: 'أذار',
        dateDay: '6',
        imageUrl: 'images/Rectangle2.png',
        venueLogoAsset: 'images/logo.png',
      ),
      PopularEvent(
        title: '3تعلم أساسيات تصميم تجربة المستخدم',
        venue: 'المحطة',
        dateMonth: 'أذار',
        dateDay: '6',
        imageUrl: 'images/Rectangle2.png',
        venueLogoAsset: 'images/logo.png',
      ),
    ],
  });

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  int _selected = 0;

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
          height: 40,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: widget.categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, i) => _CategoryChip(
              category: widget.categories[i],
              selected: i == _selected,
              onTap: () => setState(() => _selected = i),
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 330,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            padding: const EdgeInsets.symmetric(vertical: 4),
            itemCount: widget.events.length,
            separatorBuilder: (_, __) => const SizedBox(width: 15),
            itemBuilder: (context, i) => SizedBox(
              width: 350,
              child: _EventCard(event: widget.events[i]),
            ),
          ),
        ),
      ],
    );
  }
}

class PopularCategory {
  final String label;
  final IconData icon;
  const PopularCategory({required this.label, required this.icon});
}

class PopularEvent {
  final String title;
  final String venue;
  final String dateMonth;
  final String dateDay;
  final String? imageUrl;
  final String? venueLogoAsset;

  const PopularEvent({
    required this.title,
    required this.venue,
    required this.dateMonth,
    required this.dateDay,
    this.imageUrl,
    this.venueLogoAsset,
  });
}

class _CategoryChip extends StatelessWidget {
  final PopularCategory category;
  final bool selected;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.category,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const blue = Color(0xFF2F7BF4);
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: selected ? blue : const Color(0xFFE4E8EF),
            width: selected ? 1.5 : 1,
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0A000000),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              category.icon,
              size: 18,
              color: selected ? blue : const Color(0xFF78879A),
            ),
            const SizedBox(width: 6),
            Text(
              category.label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: selected ? blue : const Color(0xFF102A43),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EventCard extends StatelessWidget {
  final PopularEvent event;

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
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  width: 56,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x1F000000),
                        blurRadius: 10,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        event.dateMonth,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF78879A),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        event.dateDay,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF102A43),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Transform.translate(
            offset: const Offset(0, -24),
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
               
                  
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                       Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            
                            child: Text(
                              event.title,
                              textAlign: TextAlign.start ,
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
                          const SizedBox(width: 12),
                          Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                      color: Color(0xFF2F7BF4),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_outward_rounded,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                        ],
                      ),
                      const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                          
                         
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 251, 246, 226),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              alignment: Alignment.center,
                              child: event.venueLogoAsset != null
                                  ? Image.asset(
                                      event.venueLogoAsset!,
                                      width: 40,
                                      height: 40,
                                    )
                                  : const Text(
                                      'لا يوجد صورة',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w800,
                                        color: Color(0xFFB48800),
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
