import 'package:flutter/material.dart';

class PressableScale extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const PressableScale({
    super.key,
    required this.child,
    this.onTap,
    this.onLongPress,
  });

  @override
  State<PressableScale> createState() => _PressableScaleState();
}

class _PressableScaleState extends State<PressableScale> {
  bool _pressed = false;

  void _setPressed(bool value) {
    if (widget.onTap == null && widget.onLongPress == null) return;
    if (_pressed != value) {
      setState(() => _pressed = value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = widget.onTap != null || widget.onLongPress != null;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
      onTapDown: (_) => _setPressed(true),
      onTapUp: (_) => _setPressed(false),
      onTapCancel: () => _setPressed(false),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOutCubic,
        opacity: (_pressed && isEnabled) ? 0.92 : 1.0,
        child: AnimatedScale(
          scale: (_pressed && isEnabled) ? 0.95 : 1.0,
          duration: const Duration(milliseconds: 120),
          curve: Curves.easeOutCubic,
          child: widget.child,
        ),
      ),
    );
  }
}