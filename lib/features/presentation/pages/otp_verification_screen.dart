import 'dart:async';
import '../../data/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';


class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key, required this.phoneNumber});
  final String phoneNumber;

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  
  bool _isLoading = false;
  String _otpCode = '';
  static const int _initialSeconds = 59;
  late int _secondsRemaining;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _secondsRemaining = _initialSeconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      if (_secondsRemaining == 0) {
        timer.cancel();
      } else {
        setState(() {
          _secondsRemaining--;
        });
      }
    });
    setState(() {});
  }

  String _formatTimer(int totalSeconds) {
    final minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _verifyCode() async {
    final prefs = await SharedPreferences.getInstance();
    if (_otpCode.length < 6) return;

    setState(() => _isLoading = true);

    try {
      final repository = AuthRepository();
      await repository.request(
        url: 'https://fake-otp.vercel.app/verify-otp',
        body: {
          'phone': widget.phoneNumber,
          'code': _otpCode,
        },
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم التحقق بنجاح!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('رمز خاطئ أو حدث خطأ: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      
      await prefs.setString('phoneNumber', widget.phoneNumber);
      if (mounted) setState(() => _isLoading = false);
    }
  }

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

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
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
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFFF9FAFB),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                stops: [0.0, 0.7447, 0.8723, 1.0],
                colors: [
                  Color.fromRGBO(230, 241, 254, 0.32),
                  Color.fromRGBO(230, 241, 254, 0.32),
                  Color.fromRGBO(181, 212, 253, 0.32),
                  Color.fromRGBO(137, 186, 251, 0.32),
                ],
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 16.0,
                ),
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'التحقق من رقم الهاتف',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF102A43),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'قم بأدخال رمز التحقق الذي أرسل الى الرقم\n${widget.phoneNumber}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Pinput for the 6-digit code
                  Center(
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: Pinput(
                        length: 6,
                        defaultPinTheme: defaultPinTheme,
                        onChanged: (value) {
                          setState(() => _otpCode = value);
                        },
                        onCompleted: (pin) {
                          _verifyCode();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Timer Pill
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD3E4FA), // Light blue background
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.access_time,
                            size: 16,
                            color: Colors.blue,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _formatTimer(_secondsRemaining),
                            style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
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
                       
                            onTap: () async {
                               _startTimer();
                              try {
                                    // Call the API
                                    final repository = AuthRepository();
                                    await repository.request(
                                      url: 'https://fake-otp.vercel.app/send-otp',
                                      body: {'phone': widget.phoneNumber},
                                    );

                                    // If successful, navigate to the next screen
                                    if (!context.mounted) return;
                               
                              } catch (e) {
                                // If it fails, show an error message
                                if (!context.mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('حدث خطأ: ${e.toString()}'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              } finally {
                                // Stop loading regardless of success or failure
                                if (context.mounted) {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                }
                              }
                        },
                        child: const Text(
                          'إعادة إرسال',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  // Confirm Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: (_otpCode.length == 6 && !_isLoading)
                          ? () => _verifyCode()
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        disabledBackgroundColor: const Color(0xFFE2E8F0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
               child: _isLoading
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
                              color: _otpCode.length == 6 ? Colors.white : Colors.grey,
                            ),
                          ),
                    ),
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
