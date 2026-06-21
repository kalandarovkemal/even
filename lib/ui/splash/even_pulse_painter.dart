import 'dart:math' as math;

import 'package:flutter/widgets.dart';

import '../../core/theme/app_colors.dart';

class EvenPulsePainter extends CustomPainter {
  const EvenPulsePainter(this.t);

  final double t;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final coreRadius = size.shortestSide * 0.11;
    final maxRadius = size.shortestSide * 0.48;

    _paintRipples(canvas, center, coreRadius, maxRadius);
    _paintSweep(canvas, center, coreRadius);
    _paintCore(canvas, center, coreRadius);
  }

  void _paintRipples(Canvas canvas, Offset center, double coreRadius, double maxRadius) {
    const rings = 3;
    for (var i = 0; i < rings; i++) {
      final phase = ((t * 2.2) + i / rings) % 1.0;
      final radius = coreRadius + phase * (maxRadius - coreRadius);
      final opacity = (1.0 - phase).clamp(0.0, 1.0) * 0.55;
      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..color = AppColors.accent.withValues(alpha: opacity);
      canvas.drawCircle(center, radius, paint);
    }
  }

  void _paintSweep(Canvas canvas, Offset center, double coreRadius) {
    final radius = coreRadius + 14;
    final start = t * 2 * math.pi * 1.5;
    const sweep = 1.3;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..color = AppColors.accent
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      start,
      sweep,
      false,
      paint,
    );
  }

  void _paintCore(Canvas canvas, Offset center, double coreRadius) {
    final breathe = 1 + 0.1 * math.sin(t * 2 * math.pi * 3);
    final radius = coreRadius * breathe;

    final glow = Paint()
      ..color = AppColors.accent.withValues(alpha: 0.5)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 18);
    canvas.drawCircle(center, radius * 1.4, glow);

    final core = Paint()..color = AppColors.accent;
    canvas.drawCircle(center, radius, core);
  }

  @override
  bool shouldRepaint(EvenPulsePainter oldDelegate) => oldDelegate.t != t;
}
