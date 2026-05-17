import 'package:flutter/material.dart';

/// Bottom-edge style for [ConcaveHeaderClip].
enum ConcaveHeaderStyle {
  /// Smooth dip centered on the bottom, curving downward.
  symmetric,

  /// Large sweep on the start side, tighter corner on the end (place detail).
  asymmetric,
}

/// Clips a header image with a smooth curved bottom edge.
///
/// [curveDepth] pushes the center of the bottom edge **downward** (below the
/// main [height]), matching the hall-detail hero design.
class ConcaveHeaderClip extends StatelessWidget {
  const ConcaveHeaderClip({
    super.key,
    required this.height,
    required this.child,
    this.curveDepth = 52,
    this.edgeInset = 0,
    this.style = ConcaveHeaderStyle.symmetric,
  });

  /// Main image area height (excluding the downward curve).
  final double height;
  final Widget child;
  final double curveDepth;
  final double edgeInset;
  final ConcaveHeaderStyle style;

  @override
  Widget build(BuildContext context) {
    final totalHeight = height + curveDepth;

    return SizedBox(
      height: totalHeight,
      width: double.infinity,
      child: ClipPath(
        clipper: _ConcaveBottomClipper(
          curveDepth: curveDepth,
          edgeInset: edgeInset,
          style: style,
        ),
        child: SizedBox(
          height: totalHeight,
          width: double.infinity,
          child: child,
        ),
      ),
    );
  }
}

class _ConcaveBottomClipper extends CustomClipper<Path> {
  _ConcaveBottomClipper({
    required this.curveDepth,
    required this.edgeInset,
    required this.style,
  });

  final double curveDepth;
  final double edgeInset;
  final ConcaveHeaderStyle style;

  @override
  Path getClip(Size size) {
    final baseY = size.height - curveDepth - edgeInset;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0);

    switch (style) {
      case ConcaveHeaderStyle.symmetric:
        path
          ..lineTo(size.width, baseY)
          ..quadraticBezierTo(
            size.width * 0.5,
            size.height - edgeInset,
            0,
            baseY,
          );
      case ConcaveHeaderStyle.asymmetric:
        final endCorner = curveDepth * 0.35;
        path
          ..lineTo(size.width, baseY - endCorner)
          ..quadraticBezierTo(
            size.width,
            baseY,
            size.width - endCorner,
            baseY,
          )
          ..lineTo(size.width * 0.42, baseY)
          ..cubicTo(
            size.width * 0.18,
            baseY + curveDepth * 0.35,
            size.width * 0.06,
            size.height - edgeInset,
            0,
            baseY - curveDepth * 0.15,
          );
    }

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant _ConcaveBottomClipper oldClipper) {
    return oldClipper.curveDepth != curveDepth ||
        oldClipper.edgeInset != edgeInset ||
        oldClipper.style != style;
  }
}
