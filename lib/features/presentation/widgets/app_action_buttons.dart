import 'package:flutter/material.dart';

/// Outlined secondary action (e.g. «مسح الفلتر») — reusable across the app.
class AppOutlineActionButton extends StatelessWidget {
  const AppOutlineActionButton({
    super.key,
    required this.label,
    this.onPressed,
    this.padding = const EdgeInsets.symmetric(vertical: 14),
    this.borderRadius = 28,
  });

  final String label;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry padding;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Color(0xFFDCE3EA)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
        padding: padding,
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF7B8CA1),
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

/// Primary gradient action (e.g. «تطبيق») — matches app blue gradient.
class AppPrimaryGradientButton extends StatelessWidget {
  const AppPrimaryGradientButton({
    super.key,
    required this.label,
    this.onPressed,
    this.padding = const EdgeInsets.symmetric(vertical: 14),
    this.borderRadius = 28,
    this.gradient = const LinearGradient(
      colors: [Color(0xFF4B9CFF), Color(0xFF0F73F7)],
    ),
  });

  final String label;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        gradient: gradient,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
          padding: padding,
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}
