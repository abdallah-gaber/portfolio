import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class AuroraBackground extends StatefulWidget {
  const AuroraBackground({super.key});

  @override
  State<AuroraBackground> createState() => _AuroraBackgroundState();
}

class _AuroraBackgroundState extends State<AuroraBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 14),
  )..repeat();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: _ctrl,
    builder: (_, __) =>
        CustomPaint(painter: _AuroraPainter(_ctrl.value), size: Size.infinite),
  );
}

class _AuroraPainter extends CustomPainter {
  const _AuroraPainter(this.t);

  final double t;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = AppColors.bg,
    );
    _blob(
      canvas,
      size,
      cx: size.width * (0.12 + 0.08 * math.sin(t * math.pi * 2)),
      cy: size.height * (0.18 + 0.07 * math.cos(t * math.pi * 2)),
      r: size.width * 0.42,
      color: AppColors.violet.withValues(alpha: 0.13),
    );
    _blob(
      canvas,
      size,
      cx: size.width * (0.82 + 0.07 * math.cos(t * math.pi * 2)),
      cy: size.height * (0.14 + 0.09 * math.sin(t * math.pi * 2 + 1.0)),
      r: size.width * 0.38,
      color: AppColors.teal.withValues(alpha: 0.08),
    );
    _blob(
      canvas,
      size,
      cx: size.width * (0.5 + 0.10 * math.sin(t * math.pi * 2 + 2.1)),
      cy: size.height * (0.72 + 0.05 * math.cos(t * math.pi * 2 + 2.1)),
      r: size.width * 0.32,
      color: AppColors.coral.withValues(alpha: 0.06),
    );
  }

  void _blob(
    Canvas canvas,
    Size _, {
    required double cx,
    required double cy,
    required double r,
    required Color color,
  }) {
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [color, Colors.transparent],
      ).createShader(Rect.fromCircle(center: Offset(cx, cy), radius: r));
    canvas.drawCircle(Offset(cx, cy), r, paint);
  }

  @override
  bool shouldRepaint(_AuroraPainter old) => old.t != t;
}
