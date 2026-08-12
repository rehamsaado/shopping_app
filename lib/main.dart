import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/core/localization/app_strings.dart';
import 'package:shopping_app/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:shopping_app/features/products/presentation/blocs/products_bloc.dart';
import 'package:shopping_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'core/di/injection_container.dart' as di;
import 'core/local/app_preferences.dart';
import 'core/localization/locale_cubit.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_cubit.dart';
import 'features/auth/presentation/blocs/auth_event.dart';
import 'features/carts/presentation/bloc/carts_list/carts_list_bloc.dart';
import 'features/carts/presentation/bloc/carts_list/carts_list_event.dart';
import 'features/products/presentation/blocs/products_event.dart';
import 'features/profile/presentation/bloc/profile_event.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  di.setupLocator();

  final sharedPreferences = await SharedPreferences.getInstance();
  final appPreferences = AppPreferences(sharedPreferences);

  runApp(MyApp(appPreferences: appPreferences));
}

class MyApp extends StatelessWidget {
  final AppPreferences appPreferences;

  const MyApp({super.key, required this.appPreferences});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit(appPreferences)),
        BlocProvider(create: (_) => LocaleCubit(appPreferences)),
        BlocProvider(
          create: (_) => di.sl<AuthBloc>()..add(CheckAuthStatusRequested()),
        ),
        BlocProvider(
          create: (_) => di.sl<ProductsBloc>()..add(GetProductsEvent()),
        ),
        BlocProvider(
          create: (_) => di.sl<ProfileBloc>()..add(GetCachedProfileEvent()),
        ),
        BlocProvider(
          create: (_) =>
              di.sl<CartsListBloc>()..add(const LoadCartsListEvent()),
        ),
      ],
      child: Builder(
        builder: (context) {
          final themeMode = context.watch<ThemeCubit>().state;
          final locale = context.watch<LocaleCubit>().state;

          return MaterialApp.router(
            title: AppStrings.of("app_name", locale.languageCode),
            debugShowCheckedModeBanner: false,

            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: themeMode,
            locale: locale,

            supportedLocales: const [Locale('ar'), Locale('en')],
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],

            routerConfig: AppRouter.router,
          );
        },
      ),
    );
  }
}
