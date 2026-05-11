import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/auth_repository.dart';
import '../../login/controllers/login_controller.dart';
import '../../home/views/main_page.dart';
import '../../home/bindings/home_bindings.dart';

class OtpController extends GetxController {
  final AuthRepository _repository = AuthRepository();
  final LoginController _loginController = Get.find<LoginController>();
   String get phoneNumber => _loginController.phoneNumber.value;
  var otpCode = ''.obs;
  var isLoading = false.obs;
  var isOtpFocused = false.obs;
  final remainingSeconds = 59.obs;

  Timer? _countdownTimer;

  bool get isOtpEnabled => otpCode.value.length == 6;

  void onOtpFocusChange(bool hasFocus) {
    isOtpFocused.value = hasFocus;
  }

  void updateOtpCode(String value) {
    otpCode.value = value;
  }

  String formatTimer(int totalSeconds) {
    final minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  String get timerText => formatTimer(remainingSeconds.value);

  void _startCountdown() {
    _countdownTimer?.cancel();
    remainingSeconds.value = 59;
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (isClosed) {
        _countdownTimer?.cancel();
        _countdownTimer = null;
        return;
      }
      try {
        final current = remainingSeconds.value;
        if (current > 0) {
          remainingSeconds.value = current - 1;
        } else {
          _countdownTimer?.cancel();
          _countdownTimer = null;
        }
      } on Object {
        _countdownTimer?.cancel();
        _countdownTimer = null;
      }
    });
  }

  @override
  void onInit() {
    super.onInit();
    _startCountdown();
    sendOtp();
  }

  @override
  void onClose() {
    _countdownTimer?.cancel();
    super.onClose();
  }

  Future<void> verifyOtp() async {
   
    if (!isOtpEnabled || isLoading.value) return;
    try {
      await _repository.request(
        url: 'https://fake-otp.vercel.app/verify-otp',
        body: {'phone': phoneNumber , 'code': otpCode.value},
      );
      Get.to(() => const MainPage(), binding: HomeBinding());
    } catch (e) {
      Get.snackbar(
        'خطأ',
        'حدث خطأ في التحقق من رمز التحقق',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
    
    }
  }

  Future<void> sendOtp() async {
    try {
      await _repository.request(
        url: 'https://fake-otp.vercel.app/send-otp',
        body: {'phone': phoneNumber},
        
        
      );
  
    } catch (e) {
      Get.snackbar(
        'خطأ',
        'حدث خطأ في إرسال رمز التحقق',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,

      );
    } finally {
      _startCountdown();
    }
  }


}