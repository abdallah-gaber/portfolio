import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ScrollReveal extends StatefulWidget {
  const ScrollReveal({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.slideOffsetY = 40.0,
  });

  final Widget child;
  final Duration delay;
  final double slideOffsetY;

  @override
  State<ScrollReveal> createState() => _ScrollRevealState();
}

class _ScrollRevealState extends State<ScrollReveal> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: widget.key ?? ValueKey(hashCode),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.08 && !_visible) {
          Future.delayed(widget.delay, () {
            if (mounted) {
              setState(() => _visible = true);
            }
          });
        }
      },
      child: AnimatedOpacity(
        opacity: _visible ? 1 : 0,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOut,
        child: AnimatedSlide(
          offset: _visible ? Offset.zero : Offset(0, widget.slideOffsetY / 100),
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeOut,
          child: widget.child,
        ),
      ),
    );
  }
}
