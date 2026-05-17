import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/popular_models.dart';

class HomeController extends GetxController {
  // Observables replacing setState variables
  var isScrolled = false.obs;

  /// Matches `CustomBottomNav` indices.
  final navIndex = 0.obs;

  final searchController = TextEditingController();

  var selectedCategoryIndex = 0.obs;

  void setNavIndex(int index) {
    navIndex.value = index;
  }

  final List<PopularCategory> categories = const [
    PopularCategory(label: 'الكل', icon: Icons.apps_rounded),
    PopularCategory(label: 'التصميم', icon: Icons.brush_rounded),
    PopularCategory(label: 'التقنية والبرمجة', icon: Icons.code_rounded),
  ];

  final List<PopularEvent> events = const [
    PopularEvent(
      title: 'تعلم أساسيات تصميم تجربة المستخدم',
      venue: 'المحطة',
      dateMonth: 'آذار',
      dateDay: '6',
      imageUrl: 'images/Rectangle2.png',
      venueLogoAsset: 'images/logo.png',
    ),
    PopularEvent(
      title: 'ورشة البرمجة للمبتدئين',
      venue: 'مكارس',
      dateMonth: 'آذار',
      dateDay: '12',
      imageUrl: 'images/Rectangle2.png',
      venueLogoAsset: 'images/logo.png',
    ),
    PopularEvent(
      title: 'تصميم واجهات المستخدم',
      venue: 'المحطة',
      dateMonth: 'نيسان',
      dateDay: '3',
      imageUrl: 'images/Rectangle2.png',
      venueLogoAsset: 'images/logo.png',
    ),
  ];
  
  final List<UpcomingEvent> upcomingEvents = const [
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
    ];
  

      final List<PopularPlace> popularPlaces = const [
      PopularPlace(
        name: 'المحطة',
        locationLabel: 'كرادة خارج',
        imagePath: 'images/img2.png',
        logoPath: 'images/logo.png',
        rating: '4.9',
        halls: '8 القاعات',
        events: '3 الفعاليات',
      ),
      PopularPlace(
        name: 'المحطة',
        locationLabel: 'كرادة خارج',
        imagePath: 'images/img2.png',
        logoPath: 'images/logo.png',
        rating: '4.9',
        halls: '8 القاعات',
        events: '3 الفعاليات',
      ),
      PopularPlace(
        name: 'المحطة',
        locationLabel: 'كرادة خارج',
        imagePath: 'images/img2.png',
        logoPath: 'images/logo.png',
        rating: '4.9',
        halls: '8 القاعات',
        events: '3 الفعاليات',
      ),
    ];
    final List<HallWorkspaceItem> hallWorkspaceItems = const [
      HallWorkspaceItem(
        imagePath: 'images/img3.png',
        title: 'قاعة المحطة الكبرى للإيفنتات',
        details: 'السعة: 200 شخص   السعر: 100 د.ع للساعة',
      ),
      HallWorkspaceItem(
        imagePath: 'images/img3.png',
        title: 'قاعة المحطة الكبرى للإيفنتات',
        details: 'السعة: 200 شخص   السعر: 100 د.ع للساعة',
      ),
      HallWorkspaceItem(
        imagePath: 'images/img3.png',
        title: 'قاعة المحطة الكبرى للإيفنتات',
        details: 'السعة: 200 شخص   السعر: 100 د.ع للساعة',
      ),
      HallWorkspaceItem(
        imagePath: 'images/img3.png',
        title: 'قاعة المحطة الكبرى للإيفنتات',
        details: 'السعة: 200 شخص   السعر: 100 د.ع للساعة',
      ),
    ];
  void onScroll(double offset) {
    // Only update if the value actually changes (crosses the threshold)
    final value = offset > 4;
    if (value != isScrolled.value) {
      isScrolled.value = value;
    }
  }
  

  void openSearch() => Get.toNamed('/search');

  void cancelSearch() {
    searchController.clear();
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}