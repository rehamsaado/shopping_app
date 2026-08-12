// lib/core/router/app_router.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shopping_app/features/auth/presentation/pages/login_page.dart';
import 'package:shopping_app/features/carts/presentation/pages/carts_list_page.dart';

import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/carts/presentation/pages/cart_details_page.dart';
import '../../features/products/presentation/pages/product_details_page.dart';
import '../../features/products/presentation/pages/products_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/splash/presentation/pages/onboarding_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import '../../features/splash/presentation/splash/splash_cubit.dart';
import '../di/injection_container.dart';

abstract class AppRoutes {
  AppRoutes._();

  static const splash = '/';
  static const onboarding = '/onboarding';
  static const login = '/login';
  static const register = '/register';
  static const products = '/products';
  static const productDetails = 'details';
  static const cart = '/cart';
  static const cartDetails = 'details'; // مسار فرعي داخل السلة
  static const profile = '/profile';
}

abstract class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        pageBuilder: (context, state) => _fadeSlidePage(
          BlocProvider(
            create: (context) => sl<SplashCubit>(),
            child: const SplashPage(),
          ),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        pageBuilder: (context, state) =>
            _fadeSlidePage(const OnboardingPage(), key: state.pageKey),
      ),
      GoRoute(
        path: AppRoutes.login,
        pageBuilder: (context, state) =>
            _fadeSlidePage(const LoginPage(), key: state.pageKey),
      ),
      GoRoute(
        path: AppRoutes.register,
        pageBuilder: (context, state) =>
            _fadeSlidePage(const RegisterPage(), key: state.pageKey),
      ),
      GoRoute(
        path: AppRoutes.products,
        pageBuilder: (context, state) =>
            _fadeSlidePage(const ProductsPage(), key: state.pageKey),
        routes: [
          GoRoute(
            path: AppRoutes.productDetails,
            pageBuilder: (context, state) {
              final productId = state.extra as int? ?? 1;
              return _fadeSlidePage(
                ProductDetailsPage(productId: productId),
                key: state.pageKey,
              );
            },
          ),
        ],
      ),
      // مسارات السلال (Carts Routes)
      GoRoute(
        path: AppRoutes.cart,
        pageBuilder: (context, state) =>
            _fadeSlidePage(const CartsListPage(), key: state.pageKey),
        routes: [
          GoRoute(
            path: AppRoutes.cartDetails,
            pageBuilder: (context, state) {
              final cartId = state.extra as int? ?? 1;
              return _fadeSlidePage(
                CartDetailsPage(cartId: cartId),
                key: state.pageKey,
              );
            },
          ),
        ],
      ),
      // مسار الملف الشخصي (Profile Route) مع دعم الـ userId
      // مسار الملف الشخصي (Profile Route) مع دعم الـ userId
      GoRoute(
        path: '${AppRoutes.profile}/:userId',
        pageBuilder: (context, state) {
          final userId = state.pathParameters['userId'] ?? '1';
          return _fadeSlidePage(
            ProfileScreen(userId: userId),
            key: state.pageKey,
          );
        },
      ),
    ],
  );

  static CustomTransitionPage<void> _fadeSlidePage(
    Widget child, {
    LocalKey? key,
  }) {
    return CustomTransitionPage<void>(
      key: key,
      child: child,
      transitionDuration: const Duration(milliseconds: 260),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
        );
        return FadeTransition(
          opacity: curved,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.04),
              end: Offset.zero,
            ).animate(curved),
            child: child,
          ),
        );
      },
    );
  }
}
