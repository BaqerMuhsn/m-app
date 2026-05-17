import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/popular_models.dart';

class HallDetailController extends GetxController {
  final isLoading = false.obs;
  final currentImageIndex = 0.obs;

  final hallTitle = ''.obs;
  final capacityLabel = ''.obs;
  final priceValue = ''.obs;
  final venueName = ''.obs;
  final venueLogoPath = 'images/logo.png'.obs;

  final images = <String>[].obs;
  final amenities = <HallAmenity>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchHallDetails();
  }

  void onImageChanged(int index) {
    currentImageIndex.value = index;
  }

  Future<void> fetchHallDetails() async {
    isLoading.value = true;

    final args = Get.arguments;
    if (args is HallWorkspaceItem) {
      hallTitle.value = args.title;
      capacityLabel.value = _extractCapacity(args.details);
    }

    await Future.delayed(const Duration(milliseconds: 400));

    hallTitle.value = hallTitle.value.isEmpty
        ? 'قاعة المحطة الكبرى للإيفنتات'
        : hallTitle.value;
    capacityLabel.value = capacityLabel.value.isEmpty
        ? 'السعة: 200 شخص'
        : capacityLabel.value;
    priceValue.value = '100,000 د.ع.';
    venueName.value = 'المحطة';
    venueLogoPath.value = 'images/logo.png';

    images.assignAll([
      'images/img3.png',
      'images/img3.png',
      'images/img3.png',
    ]);

    amenities.assignAll(const [
      HallAmenity(icon: Icons.local_parking_outlined, label: 'موقف سيارات'),
      HallAmenity(icon: Icons.wifi_rounded, label: 'أنترنت مجاني'),
      HallAmenity(icon: Icons.cast_for_education_outlined, label: 'شاشات عرض'),
    ]);

    isLoading.value = false;
  }

  String _extractCapacity(String details) {
    final match = RegExp(r'السعة:\s*[^|]+').firstMatch(details);
    return match?.group(0)?.trim() ?? details;
  }

  void bookHall() {}

  void contactSupport() {}
}
