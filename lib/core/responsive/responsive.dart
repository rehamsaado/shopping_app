import 'package:flutter/material.dart';

enum ScreenSize { mobile, tablet, desktop }

class Breakpoints {
  Breakpoints._();

  static const double tablet = 600;
  static const double desktop = 1024;
}

extension ResponsiveX on BuildContext {
  double get screenWidth => MediaQuery.sizeOf(this).width;

  ScreenSize get screenSize {
    final width = screenWidth;
    if (width >= Breakpoints.desktop) return ScreenSize.desktop;
    if (width >= Breakpoints.tablet) return ScreenSize.tablet;
    return ScreenSize.mobile;
  }

  bool get isMobile => screenSize == ScreenSize.mobile;
  bool get isTablet => screenSize == ScreenSize.tablet;
  bool get isDesktop => screenSize == ScreenSize.desktop;

  int get gridColumns {
    switch (screenSize) {
      case ScreenSize.mobile:
        return 1;
      case ScreenSize.tablet:
        return 2;
      case ScreenSize.desktop:
        return 4;
    }
  }

  double get contentMaxWidth {
    switch (screenSize) {
      case ScreenSize.mobile:
        return double.infinity;
      case ScreenSize.tablet:
        return 720;
      case ScreenSize.desktop:
        return 1100;
    }
  }
}

class ResponsiveCenter extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const ResponsiveCenter({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: context.contentMaxWidth),
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}
