import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class StaggeredFadeIn extends StatelessWidget {
  final int index;
  final Widget child;

  const StaggeredFadeIn({
    super.key,
    required this.index,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final delay = Duration(milliseconds: 45 * index.clamp(0, 12));

    return child
        .animate(delay: delay)
        .fadeIn(
      duration: 380.ms,
      curve: Curves.easeOut,
    )
        .slideY(
      begin: 0.1,
      end: 0,
      duration: 380.ms,
      curve: Curves.easeOutCubic,
    )
        .scaleXY(
      begin: 0.96,
      end: 1.0,
      duration: 380.ms,
      curve: Curves.easeOutCubic,
    );
  }
}