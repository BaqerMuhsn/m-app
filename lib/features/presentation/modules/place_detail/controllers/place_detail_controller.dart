import 'package:get/get.dart';

import '../../../model/popular_models.dart';
import '../views/widgets/leave_review_sheet.dart';

class PlaceDetailController extends GetxController {
  final isLoading = false.obs;

  final placeName = ''.obs;
  final placeLocation = ''.obs;
  final placeDescription = ''.obs;
  final rating = 0.0.obs;
  final reviewsCount = 0.obs;
  final List<HallWorkspaceItem> halls = [];
  final List<PopularEvent> events = [];

  @override
  void onInit() {
    super.onInit();

    fetchPlaceDetailsData();
  }

  void fetchPlaceDetails() {
    isLoading.value = true;
    
  }
  Future<void> fetchPlaceDetailsData() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1));
    placeName.value = "المحطة";
    placeLocation.value = "كرادة خارج";
    placeDescription.value = "مرحبًا بك في المحطة ، الوجهة المثالية لاستضافة فعالياتك، اجتماعاتك، والعمل المشترك. استمتع بتجربة فريدة في أجواء مريحة وخدمات متكاملة تناسب جميع احتياجاتك.";
    rating.value = 4.9;
    reviewsCount.value = 1000;
    halls.assignAll([
      HallWorkspaceItem(
        imagePath: 'images/img3.png',
        title: 'قاعة المحطة الكبرى للإيفنتات',
        details: 'السعة: 200 شخص   السعر: 100 د.ع للساعة',
      ),
      HallWorkspaceItem(
        imagePath: 'images/img3.png',
        title: 'مساحة عمل مشتركة',
        details: 'السعة: 50 شخص   السعر: 50 د.ع للساعة',
      ),
    ]);
    events.assignAll([
      PopularEvent(
        title: 'تعلم أساسيات تصميم تجربة المستخدم',
        venue: 'المحطة',
        dateMonth: 'آذار',
        dateDay: '6',
        imageUrl: 'images/Rectangle2.png',
        venueLogoAsset: 'images/logo.png',
      ),
    ]);
    isLoading.value = false;
  }
  void leaveReview() {
    final context = Get.context;
    if (context == null) return;
    LeaveReviewSheet.show(context);
  }
}

