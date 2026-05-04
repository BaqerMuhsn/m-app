import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';
import '../../../widgets/gradient_scaffold.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GradientScaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'تسجيل الدخول',
            style: TextStyle(color: Color(0xFF102A43), fontSize: 18, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            width: double.infinity,
            height: double.infinity,
              
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const Text('أدخل معلومات حسابك', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Color(0xFF102A43))),
                    const SizedBox(height: 8),
                    const Text('أدخل رقم هاتفك المسجل لدينا لتسجيل الدخول الى حسابك بنجاح .', style: TextStyle(fontSize: 14, color: Colors.grey)),
                    const SizedBox(height: 32),
                    const Text('رقم الهاتف', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF102A43))),
                    const SizedBox(height: 8),
                    Focus(
                      onFocusChange: (hasFocus) => controller.onPhoneFocusChange(hasFocus),
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(11)],
                        onChanged: (value) => controller.updatePhoneNumber(value),
                        decoration: InputDecoration(
                          hintText: '0000 000 0770',
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Obx(() => SvgPicture.asset(
                              'images/04_call-02.svg',
                              width: 25,
                              height: 25,
                              colorFilter: ColorFilter.mode(
                                controller.isPhoneFocused.value ? Colors.blue : Colors.grey,
                                BlendMode.srcIn,
                              ),
                            )),
                          ),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                        ),
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: Obx(() => ElevatedButton(
                        onPressed: controller.isLoginEnabled ? () => controller.sendOtp() : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          disabledBackgroundColor: const Color(0xFFE2E8F0),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                        ),
                        child: controller.isLoading.value
                            ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                            : Text(
                                ' ارسال رمز التحقق',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: controller.isLoginEnabled ? Colors.white : Colors.grey,
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
        ),
      ),
    );
  }
}