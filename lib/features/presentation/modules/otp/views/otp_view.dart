import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import '../controllers/otp_controller.dart';
import '../../../widgets/gradient_scaffold.dart';

class OtpView extends GetView<OtpController> {
  const OtpView({super.key});

  @override
  Widget build(BuildContext context) {
    // Define the style for the 6 input boxes
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 20,
        color: Color(0xFF102A43),
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
    );

    // Gradient + RTL + status bar styling come from [GradientScaffold]; only put
    // screen content in [body] (no second gradient / Directionality wrapper).
    return GradientScaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'تسجيل الدخول',
          style: TextStyle(
            color: Color(0xFF102A43),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color(0xFF102A43)),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                    const SizedBox(height: 20),
                    const Text(
                      'التحقق من رقم الهاتف',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Color(0xFF102A43)),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'قم بأدخال رمز التحقق الذي أرسل الى الرقم\n${controller.phoneNumber}',
                      style: const TextStyle(fontSize: 14, color: Colors.grey, height: 1.5),
                    ),
                    const SizedBox(height: 32),

                    // Pinput for the 6-digit code
                    Center(
                      child: Directionality(
                        textDirection: TextDirection.ltr,
                        child: Pinput(
                          length: 6,
                          defaultPinTheme: defaultPinTheme,
                          onChanged: (value) => controller.updateOtpCode(value),
                          onCompleted: (pin) => controller.verifyOtp(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Timer Pill
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD3E4FA),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.access_time, size: 16, color: Colors.blue),
                            const SizedBox(width: 8),
                            // Reactive timer text
                            Obx(() => Text(
                              controller.timerText,
                              style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 14),
                            )),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Resend text
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'لم تتلقى رسالة؟ ',
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                        GestureDetector(
                          onTap: () => controller.sendOtp(),
                          child: const Text(
                            'إعادة إرسال',
                            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                        ),
                      ],
                    ),

                    const Spacer(),

                    // Confirm Button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: Obx(() => ElevatedButton(
                        onPressed: (controller.isOtpEnabled && !controller.isLoading.value)
                            ? () => controller.verifyOtp()
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          disabledBackgroundColor: const Color(0xFFE2E8F0),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                        ),
                        child: controller.isLoading.value
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                              )
                            : Text(
                                'تأكيد',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: controller.isOtpEnabled ? Colors.white : Colors.grey,
                                ),
                              ),
                      )),
                    ),
                    const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}