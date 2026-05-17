import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/popular_models.dart';
import '../../../widgets/app_action_buttons.dart';
import '../../../widgets/concave_header_clip.dart';
import '../../../widgets/gradient_scaffold.dart';
import '../controllers/hall_detail_controller.dart';

class HallDetailPage extends GetView<HallDetailController> {
  const HallDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      extendBody: true,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 160),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _HallImageHeader(controller: controller),
              Padding(
                padding: const EdgeInsets.fromLTRB(23, 24, 23, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.hallTitle.value,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF001F3F),
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _CapacityChip(label: controller.capacityLabel.value),
                    const SizedBox(height: 28),
                    const Center(
                      child: Text(
                        'وسائل الراحة المقدمة',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF78879A),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 110,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        clipBehavior: Clip.none,
                        itemCount: controller.amenities.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 12),
                        itemBuilder: (context, i) => _AmenityCard(
                          amenity: controller.amenities[i],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
      bottomNavigationBar: Obx(
        () => controller.isLoading.value
            ? const SizedBox.shrink()
            : _HallBookingBar(controller: controller),
      ),
    );
  }
}

class _HallImageHeader extends StatelessWidget {
  const _HallImageHeader({required this.controller});

  final HallDetailController controller;

  @override
  Widget build(BuildContext context) {
    return ConcaveHeaderClip(
      height: 350,
      curveDepth: 80,
      child: Stack(
        fit: StackFit.expand,
        children: [
          PageView.builder(
            itemCount: controller.images.length,
            onPageChanged: controller.onImageChanged,
            itemBuilder: (context, index) => Image.asset(
              controller.images[index],
              fit: BoxFit.cover,
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0x33000000), Color(0x00000000), Color(0x66000000)],
                stops: [0.0, 0.45, 1.0],
              ),
            ),
          ),
          SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: Get.back,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.92),
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(color: const Color(0xFFD4DADD)),
                            ),
                            child: const Icon(
                              Icons.keyboard_arrow_right,
                              color: Color(0xFF1A1A1A),
                            ),
                          ),
                        ),
                        _VenueBadge(
                          name: controller.venueName.value,
                          logoPath: controller.venueLogoPath.value,
                        ),
                      ],
                    ),
                    const Spacer(),
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(controller.images.length, (index) {
                          final active = index == controller.currentImageIndex.value;
                          return Container(
                            width: active ? 8 : 6,
                            height: active ? 8 : 6,
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            decoration: BoxDecoration(
                              color: active ? Colors.white : Colors.white.withValues(alpha: 0.45),
                              shape: BoxShape.circle,
                            ),
                          );
                        }),
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

class _VenueBadge extends StatelessWidget {
  const _VenueBadge({required this.name, required this.logoPath});

  final String name;
  final String logoPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE4E8EF)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(logoPath, width: 22, height: 22, fit: BoxFit.contain),
          const SizedBox(width: 6),
          Text(
            name,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Color(0xFF102A43),
            ),
          ),
        ],
      ),
    );
  }
}

class _CapacityChip extends StatelessWidget {
  const _CapacityChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F2FF),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFD6E8FF)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.groups_outlined, size: 18, color: Color(0xFF3A8CFF)),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Color(0xFF3A8CFF),
            ),
          ),
        ],
      ),
    );
  }
}

class _AmenityCard extends StatelessWidget {
  const _AmenityCard({required this.amenity});

  final HallAmenity amenity;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF3FF),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFD6E8FF)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(amenity.icon, size: 28, color: const Color(0xFF3A8CFF)),
          const SizedBox(height: 10),
          Text(
            amenity.label,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Color(0xFF102A43),
            ),
          ),
        ],
      ),
    );
  }
}

class _HallBookingBar extends StatelessWidget {
  const _HallBookingBar({required this.controller});

  final HallDetailController controller;

  @override
  Widget build(BuildContext context) {
    final bottomPad = MediaQuery.paddingOf(context).bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(16, 0, 16, bottomPad + 12),
      child: Container(
        padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: const Color(0xFFE8EDF2)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1A000000),
              blurRadius: 24,
              offset: Offset(0, -4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'السعر للساعة الواحدة',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF78879A),
                  ),
                ),
                Obx(
                  () => Text(
                    controller.priceValue.value,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF001F3F),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                _SupportButton(onTap: controller.contactSupport),
                const SizedBox(width: 12),
                Expanded(
                  child: AppPrimaryGradientButton(
                    label: 'حجز القاعة',
                    onPressed: controller.bookHall,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SupportButton extends StatelessWidget {
  const _SupportButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(side: BorderSide(color: Color(0xFFDCE3EA))),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: const SizedBox(
          width: 50,
          height: 50,
          child: Icon(
            Icons.headset_mic_outlined,
            color: Color(0xFF7B8CA1),
            size: 22,
          ),
        ),
      ),
    );
  }
}
