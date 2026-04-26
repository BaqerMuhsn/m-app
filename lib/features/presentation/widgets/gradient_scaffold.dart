import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GradientScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final List<Color>? colors;

  const GradientScaffold({
    super.key,
    this.appBar,
    required this.body,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.extendBody = false,
    this.extendBodyBehindAppBar = true,
    this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      // 1. إصلاح الأشرطة العلوية والسفلية لجعلها شفافة بدل الأسود
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark, 
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          // Matches body base so any gap is not stark white.
          backgroundColor: const Color(0xFFF9FAFB),
          extendBodyBehindAppBar: extendBodyBehindAppBar,
          appBar: appBar,
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAFB),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                stops: const [0.0, 0.7447, 0.8723, 1.0],
                colors: colors ??
                    const [
                      Color.fromRGBO(230, 241, 254, 0.32),
                      Color.fromRGBO(230, 241, 254, 0.32),
                      Color.fromRGBO(181, 212, 253, 0.32),
                      Color.fromRGBO(137, 186, 251, 0.32),
                    ],
              ),
            ),
            child: body,

          ),
          // Lets the gradient show through rounded / transparent parts of the bar.
          bottomNavigationBar: bottomNavigationBar == null
              ? null
              : Material(
                  type: MaterialType.transparency,
                  color: Colors.transparent,
                  surfaceTintColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  elevation: 0,
                  child: bottomNavigationBar,
                ),
          floatingActionButton: floatingActionButton,
          extendBody: extendBody || bottomNavigationBar != null,
        ),
      ),
    );
  }
}