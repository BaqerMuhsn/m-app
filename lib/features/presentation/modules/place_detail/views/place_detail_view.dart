import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/event_card.dart';
import '../../../widgets/gradient_scaffold.dart';
import '../../../widgets/hall_card.dart';
import '../controllers/place_detail_controller.dart';

Widget _buildInfoItem(String label, IconData icon) {
  return Row(
    children: [
      Text(
        label,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Color(0xFF001F3F),
        ),
      ),
      const SizedBox(width: 4),
      Icon(icon, color: Colors.blue, size: 18),
    ],
  );
}

// Change to GetView to automatically link the controller
class PlaceDetailPage extends GetView<PlaceDetailController> {
  const PlaceDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      // Use Obx to react to changes (like loading state)
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 250,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(180),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 62),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 23),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () => Get.back(),
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(color: const Color(0xFFD4DADD)),
                                  ),
                                  child: const Icon(
                                    Icons.keyboard_arrow_right,
                                    color: Color(0xFF1A1A1A),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: controller.leaveReview,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  spacing: 2,
                                  children: const [
                                    Icon(
                                      Icons.star_border,
                                      size: 16,
                                      color: Color(0xFF70848F),
                                    ),
                                    Text(
                                      'أترك تقييماً',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF70848F),
                                      ),
                                    ),
                                    Icon(
                                      Icons.keyboard_arrow_left,
                                      size: 16,
                                      color: Color(0xFF70848F),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                spacing: 1,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 20),
                                  // Connect to Controller
                                  Text(
                                    controller.placeName.value,
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF001F3F),
                                    ),
                                  ),
                                  const SizedBox(height: 4),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.placeLocation.value,
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 18,
                                      ),
                                      Text(
                                        " ${controller.rating.value} (+${controller.reviewsCount.value})",
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      _buildInfoItem(
                                        "القاعات: ${controller.halls.length}",
                                        Icons.event_seat_outlined,
                                      ),
                                      const SizedBox(width: 15),
                                      _buildInfoItem(
                                        "الفعاليات: ${controller.events.length}",
                                        Icons.local_activity_outlined,
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              Container(
                                margin: const EdgeInsets.only(top: 30),
                                width: 100,
                                height: 100,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  border: Border.all(color: const Color(0xFFD4DADD)),
                                  borderRadius: BorderRadius.circular(100),
                                  image: const DecorationImage(
                                    image: AssetImage('images/computing_thumb.png'),
                                    fit: BoxFit.cover,
                                  ),
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
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 23),
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.topRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'عن المكان',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF021B3B),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        controller.placeDescription.value,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF021B3B),
                        ),
                      ),
                      const SizedBox(height: 25),
                      const Text(
                        'أقسام المكان',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF021B3B),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 310,
                        // Use controller list
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          clipBehavior: Clip.none,
                          itemCount: controller.halls.length,
                          separatorBuilder: (_, __) => const SizedBox(width: 16),
                          itemBuilder: (context, i) => SizedBox(
                            width: 350,
                            child: HallCard(item: controller.halls[i]),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      const Text(
                        'فعاليات',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF021B3B),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 330,
                        // Use controller list
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          clipBehavior: Clip.none,
                          itemCount: controller.events.length,
                          separatorBuilder: (_, __) => const SizedBox(width: 16),
                          itemBuilder: (context, i) => SizedBox(
                            width: 350,
                            child: EventCard(event: controller.events[i]),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}