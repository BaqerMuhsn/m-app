import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'otp_verification_screen.dart';
import '../../data/auth_repository.dart'; // 1. Import your repository here

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPhoneFocused = false;
  String _phoneNumber = '';

  // 2. Add a loading state variable
  bool _isLoading = false;

  bool get _isLoginEnabled {
    return RegExp(r'^\d{11}$').hasMatch(_phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        extendBodyBehindAppBar: true,

        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
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
                      'أدخل معلومات حسابك',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF102A43),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'أدخل رقم هاتفك المسجل لدينا لتسجيل الدخول الى حسابك بنجاح .',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 32),

                    const Text(
                      'رقم الهاتف',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF102A43),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Focus(
                      onFocusChange: (hasFocus) {
                        setState(() => _isPhoneFocused = hasFocus);
                      },
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(11),
                        ],
                        onChanged: (value) {
                          setState(() => _phoneNumber = value);
                        },
                        decoration: InputDecoration(
                          hintText: '0000 000 0770',
                          hintStyle: const TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: Colors.white,
                          prefixIconConstraints: const BoxConstraints(
                            minWidth: 25,
                            minHeight: 25,
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(
                              'images/04_call-02.svg',
                              width: 25,
                              height: 25,
                              colorFilter: ColorFilter.mode(
                                _isPhoneFocused ? Colors.blue : Colors.grey,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Spacer(),

                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        // 3. Update onPressed logic to handle the API call
                        onPressed: (_isLoginEnabled && !_isLoading)
                            ? () async {
                                // Start loading
                                setState(() {
                                  _isLoading = true;
                                });

                                try {
                                  // Call the API
                                  final repository = AuthRepository();
                                  await repository.request(
                                    url: 'https://fake-otp.vercel.app/send-otp',
                                    body: {'phone': _phoneNumber},
                                  );
                                  // If successful, navigate to the next screen
                                  if (!context.mounted) return;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          OtpVerificationScreen(
                                            phoneNumber: _phoneNumber,
                                          ),
                                    ),
                                  );
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
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          disabledBackgroundColor: const Color(0xFFE2E8F0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                        ),
                        // 4. Update the child to show a loading spinner when active
                        child: _isLoading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                ' ارسال رمز التحقق',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: _isLoginEnabled
                                      ? Colors.white
                                      : Colors.grey,
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
