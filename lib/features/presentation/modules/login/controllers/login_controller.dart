import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/auth_repository.dart';
import '../../otp/bindings/otp_binding.dart';
import '../../otp/views/otp_view.dart';

class LoginController extends GetxController {
  final AuthRepository _repository = AuthRepository();
  
  // Observable variables
  var phoneNumber = ''.obs;
  var isLoading = false.obs;
  var isPhoneFocused = false.obs;

  // Computed property for validation
  bool get isLoginEnabled => RegExp(r'^\d{11}$').hasMatch(phoneNumber.value);

  void onPhoneFocusChange(bool hasFocus) {
    isPhoneFocused.value = hasFocus;
  }

  void updatePhoneNumber(String value) {
    phoneNumber.value = value;
  }

  Future<void> sendOtp() async {
    if (!isLoginEnabled || isLoading.value) return;

    isLoading.value = true;
    try {
      await _repository.request(
        url: 'https://fake-otp.vercel.app/send-otp',
        body: {'phone': phoneNumber.value },
      );
      
      // Navigate using GetX (No context needed)
      Get.to(() => const OtpView(), binding: OtpBinding());
      
    } catch (e) {
      Get.snackbar(
        'خطأ',
        'حدث خطأ: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}