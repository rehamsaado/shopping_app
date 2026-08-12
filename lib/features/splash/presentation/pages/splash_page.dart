import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/app_router.dart';
import '../splash/splash_cubit.dart';
import '../splash/splash_state.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    context.read<SplashCubit>().checkStatus();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is SplashOnboarding) {
          context.go(AppRoutes.onboarding);
        } else if (state is SplashAuthenticated) {
          context.go(AppRoutes.products);
        } else if (state is SplashUnauthenticated) {
          context.go(AppRoutes.login);
        }
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer.withValues(alpha: 0.4),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.shopping_bag_rounded,
                  size: 64,
                  color: theme.colorScheme.primary,
                ),
              )
                  .animate(onPlay: (controller) => controller.repeat(reverse: true))
                  .scale(
                begin: const Offset(0.95, 0.95),
                end: const Offset(1.05, 1.05),
                duration: 1200.ms,
                curve: Curves.easeInOut,
              ),
              const SizedBox(height: 32),
              Text(
                'Shopping App',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.2, end: 0),
              const SizedBox(height: 24),
              SizedBox(
                width: 28,
                height: 28,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: theme.colorScheme.primary,
                ),
              ).animate().fadeIn(duration: 600.ms, delay: 200.ms),
            ],
          ),
        ),
      ),
    );
  }
}