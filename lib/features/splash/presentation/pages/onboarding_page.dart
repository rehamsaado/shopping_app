import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/local/app_preferences.dart';
import '../../../../core/localization/app_strings.dart';
import '../../../../core/router/app_router.dart';

class OnboardingItem {
  final String titleKey;
  final String descKey;
  final IconData icon;

  const OnboardingItem({
    required this.titleKey,
    required this.descKey,
    required this.icon,
  });
}

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<OnboardingItem> _items = const [
    OnboardingItem(
      titleKey: 'onboarding_title_1',
      descKey: 'onboarding_desc_1',
      icon: Icons.shopping_bag_outlined,
    ),
    OnboardingItem(
      titleKey: 'onboarding_title_2',
      descKey: 'onboarding_desc_2',
      icon: Icons.shopping_cart_outlined,
    ),
    OnboardingItem(
      titleKey: 'onboarding_title_3',
      descKey: 'onboarding_desc_3',
      icon: Icons.local_shipping_outlined,
    ),
  ];

  Future<void> _completeOnboarding() async {
    final appPreferences = GetIt.instance<AppPreferences>();
    await appPreferences.setData(key: 'is_first_time', value: false);
    if (mounted) {
      context.go(AppRoutes.login);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final langCode = Localizations.localeOf(context).languageCode;
    final isLastPage = _currentIndex == _items.length - 1;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top Navigation: Back Button & Skip Button for optimal UX
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Show back button only if not on the first page
                  _currentIndex > 0
                      ? TextButton.icon(
                    onPressed: () {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    icon: const Icon(Icons.arrow_back_ios_rounded, size: 14),
                    label: Text(AppStrings.of('back', langCode)),
                    style: TextButton.styleFrom(
                      foregroundColor: theme.colorScheme.onSurfaceVariant,
                      padding: EdgeInsets.zero,
                    ),
                  )
                      : const SizedBox.shrink(),
                  TextButton(
                    onPressed: _completeOnboarding,
                    style: TextButton.styleFrom(
                      foregroundColor: theme.colorScheme.onSurfaceVariant,
                    ),
                    child: Text(AppStrings.of('skip', langCode)),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _items.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  final item = _items[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(36),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primaryContainer
                                .withValues(alpha: 0.4),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: theme.colorScheme.primary.withValues(alpha: 0.15),
                              width: 1.5,
                            ),
                          ),
                          child: Icon(
                            item.icon,
                            size: 76,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 48),
                        Text(
                          AppStrings.of(item.titleKey, langCode),
                          style: theme.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          AppStrings.of(item.descKey, langCode),
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ).animate(key: ValueKey(index)).fadeIn(duration: 400.ms).slideY(begin: 0.05, end: 0);
                },
              ),
            ),
            // Page Indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _items.length,
                    (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 8,
                  width: _currentIndex == index ? 28 : 8,
                  decoration: BoxDecoration(
                    color: _currentIndex == index
                        ? theme.colorScheme.primary
                        : theme.colorScheme.outlineVariant.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            // Bottom Action Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    if (isLastPage) {
                      _completeOnboarding();
                    } else {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Text(
                    isLastPage
                        ? AppStrings.of('start_now', langCode)
                        : AppStrings.of('next', langCode),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}