import 'dart:async';
import 'package:flutter/material.dart';

class AutoImageCarousel extends StatefulWidget {
  final List<String> images;
  final BorderRadius? borderRadius;
  final String? heroTag;

  const AutoImageCarousel({
    super.key,
    required this.images,
    this.borderRadius,
    this.heroTag,
  });

  @override
  State<AutoImageCarousel> createState() => _AutoImageCarouselState();
}

class _AutoImageCarouselState extends State<AutoImageCarousel> {
  int _index = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimerIfNeeded();
  }

  @override
  void didUpdateWidget(covariant AutoImageCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.images.length != widget.images.length) {
      _index = 0;
      _startTimerIfNeeded();
    }
  }

  void _startTimerIfNeeded() {
    _timer?.cancel();
    if (widget.images.length > 1) {
      _timer = Timer.periodic(const Duration(seconds: 4), (_) {
        if (!mounted) return;
        setState(() => _index = (_index + 1) % widget.images.length);
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Widget _buildImage(BuildContext context, String url) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final image = Image.network(
      url,
      key: ValueKey(url),
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (context, error, stackTrace) => Container(
        color: colorScheme.surfaceContainerHigh,
        child: Icon(
          Icons.restaurant_rounded,
          color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
          size: 32,
        ),
      ),
    );

    if (widget.heroTag != null && _index == 0) {
      return Hero(
        tag: widget.heroTag!,
        child: image,
      );
    }
    return image;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.images.isEmpty) return const SizedBox.shrink();

    final colorScheme = Theme.of(context).colorScheme;
    final effectiveRadius = widget.borderRadius ?? BorderRadius.circular(20);

    Widget content = ClipRRect(
      borderRadius: effectiveRadius,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 700),
        switchInCurve: Curves.easeOutCubic,
        switchOutCurve: Curves.easeInCubic,
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: Tween<double>(begin: 1.03, end: 1.0).animate(animation),
              child: child,
            ),
          );
        },
        child: _buildImage(context, widget.images[_index]),
      ),
    );

    if (widget.images.length <= 1) return content;

    return ClipRRect(
      borderRadius: effectiveRadius,
      child: Stack(
        fit: StackFit.expand,
        children: [
          content,
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 50,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.5),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.images.length, (i) {
                final active = i == _index;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic,
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: active ? 20 : 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: active
                        ? colorScheme.primary
                        : Colors.white.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(999),
                    boxShadow: active
                        ? [
                      BoxShadow(
                        color: colorScheme.primary.withValues(alpha: 0.6),
                        blurRadius: 6,
                        spreadRadius: 1,
                      ),
                    ]
                        : null,
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}