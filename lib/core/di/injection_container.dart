// =================== Core / Network ===================

import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../features/carts/data/datasources/cart_remote_data_source.dart';
import '../../features/carts/domain/usecases/create_cart_usecase.dart';
import '../../features/carts/domain/usecases/delete_cart_usecase.dart';
import '../constants/user_session.dart';
import '../network/api_interceptors.dart';
import '../network/api_service.dart';
import '../local/app_preferences.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

// =================== Splash ===================
import '../../features/splash/data/datasources/splash_local_data_source.dart';
import '../../features/splash/data/repositories/splash_repository_impl.dart';
import '../../features/splash/domain/repositories/splash_repository.dart';
import '../../features/splash/domain/usecases/check_app_start_status_usecase.dart';
import '../../features/splash/presentation/splash/splash_cubit.dart';

// =================== Auth ===================
import 'package:shopping_app/features/auth/domain/usecases/get_saved_user_usecase.dart';
import 'package:shopping_app/features/auth/domain/usecases/logout_usecase.dart';
import '../../features/auth/data/data_source/auth_local_data_source.dart';
import '../../features/auth/data/data_source/auth_remote_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/register_usecase.dart';
import '../../features/auth/presentation/blocs/auth_bloc.dart';

//====================products================
import '../../features/products/data/data_source/products_remote_data_source.dart';
import '../../features/products/data/repositories/products_repository_impl.dart';
import '../../features/products/domain/usecases/add_product_usecase.dart';
import '../../features/products/domain/usecases/delete_product_usecase.dart';
import '../../features/products/domain/usecases/get_all_products_usecase.dart';
import '../../features/products/domain/usecases/get_product_details_usecase.dart';
import '../../features/products/domain/usecases/update_product_usecase.dart';
import 'package:shopping_app/features/products/data/data_source/products_local_data_source.dart';
import 'package:shopping_app/features/products/domain/repositories/products_repository.dart';
import 'package:shopping_app/features/products/presentation/blocs/products_bloc.dart';

//=================carts===========================
import '../../features/carts/data/datasources/cart_local_data_source.dart';
import '../../features/carts/domain/repositories/cart_repository.dart';
import '../../features/carts/domain/usecases/get_all_carts_usecase.dart';
import '../../features/carts/domain/usecases/get_cart_by_id_usecase.dart';
import '../../features/carts/domain/usecases/remove_product_from_cart_usecase.dart';
import '../../features/carts/domain/usecases/seed_initial_carts_usecase.dart';
import '../../features/carts/domain/usecases/update_product_quantity_usecase.dart';
import '../../features/carts/presentation/bloc/cart_details/cart_details_bloc.dart';
import '../../features/carts/presentation/bloc/carts_list/carts_list_bloc.dart';
import '../../features/carts/data/repositories/cart_repository_impl.dart';

//======================profile==================================
import '../../features/profile/data/data_source/profile_local_data_source.dart';
import '../../features/profile/data/data_source/profile_remote_data_source.dart';
import '../../features/profile/data/repositories/profile_repositories_imp.dart';
import '../../features/profile/domain/repository/profile_repository.dart';
import '../../features/profile/domain/usecases/user/cache_profile_details_usecase.dart';
import '../../features/profile/domain/usecases/user/get_cached_profile_details_usecase.dart';
import '../../features/profile/domain/usecases/user/get_profile_details_usecase.dart';
import '../../features/profile/presentation/bloc/profile_bloc.dart';
import '../network/network_info.dart';

final sl = GetIt.instance;

Future<void> setupLocator() async {
  // =========================================================================
  //                      1. Core & External
  // =========================================================================
  final sharedPreferences = await SharedPreferences.getInstance();

  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  sl.registerLazySingleton<AppPreferences>(
    () => AppPreferences(sl<SharedPreferences>()),
  );

  sl.registerLazySingleton<ApiInterceptor>(
    () => ApiInterceptor(sl<AppPreferences>()),
  );

  sl.registerLazySingleton<ApiService>(() => ApiService(sl<ApiInterceptor>()));
  sl.registerLazySingleton(() => UserSession(sl()));

  // =========================================================================
  //                    2. Splash Feature
  // =========================================================================
  sl.registerFactory<SplashCubit>(
    () => SplashCubit(
      checkAppStartStatusUseCase: sl<CheckAppStartStatusUseCase>(),
    ),
  );

  sl.registerLazySingleton<CheckAppStartStatusUseCase>(
    () => CheckAppStartStatusUseCase(sl<SplashRepository>()),
  );

  sl.registerLazySingleton<SplashRepository>(
    () => SplashRepositoryImpl(localDataSource: sl<SplashLocalDataSource>()),
  );

  sl.registerLazySingleton<SplashLocalDataSource>(
    () => SplashLocalDataSourceImpl(appPreferences: sl<AppPreferences>()),
  );

  // =========================================================================
  //                        3. Auth Feature
  // =========================================================================
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(authRepository: sl<AuthRepository>(), userSession: sl()),
  );

  sl.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(sl<AuthRepository>()),
  );

  sl.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(sl<AuthRepository>()),
  );
  sl.registerLazySingleton<GetSavedUserUseCase>(
    () => GetSavedUserUseCase(sl<AuthRepository>()),
  );
  sl.registerLazySingleton<LogoutUseCase>(
    () => LogoutUseCase(sl<AuthRepository>()),
  );

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      localDataSource: sl<AuthLocalDataSource>(),
      remoteDataSource: sl<AuthRemoteDataSource>(),
    ),
  );

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(apiService: sl<ApiService>()),
  );

  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(appPreferences: sl<AppPreferences>()),
  );

  // =========================================================================
  //                        4. Products Feature
  // =========================================================================

  // Bloc
  sl.registerFactory<ProductsBloc>(
    () => ProductsBloc(productsRepository: sl<ProductsRepository>()),
  );

  // Use Cases
  sl.registerLazySingleton<GetProductsUseCase>(
    () => GetProductsUseCase(sl<ProductsRepository>()),
  );
  sl.registerLazySingleton<AddProductUseCase>(
    () => AddProductUseCase(sl<ProductsRepository>()),
  );
  sl.registerLazySingleton<DeleteProductUseCase>(
    () => DeleteProductUseCase(sl<ProductsRepository>()),
  );

  sl.registerLazySingleton<GetProductDetailsUseCase>(
    () => GetProductDetailsUseCase(sl<ProductsRepository>()),
  );
  sl.registerLazySingleton<UpdateProductUseCase>(
    () => UpdateProductUseCase(sl<ProductsRepository>()),
  );

  // Repository
  sl.registerLazySingleton<ProductsRepository>(
    () => ProductsRepositoryImpl(
      remoteDataSource: sl<ProductsRemoteDataSource>(),
      localDataSource: sl<ProductsLocalDataSource>(),
    ),
  );

  // Data Sources
  sl.registerLazySingleton<ProductsRemoteDataSource>(
    () => ProductsRemoteDataSourceImpl(apiService: sl<ApiService>()),
  );
  sl.registerLazySingleton<ProductsLocalDataSource>(
    () => ProductsLocalDataSourceImpl(appPreferences: sl()),
  );

  // =========================================================================
  //                        5. Carts Feature
  // =========================================================================

  // ---- Data sources ----
  sl.registerLazySingleton<CartLocalDataSource>(
    () => CartLocalDataSourceImpl(sl<AppPreferences>()),
  );

  // ---- Repository ----
  sl.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(localDataSource: sl(), remoteDataSource: sl()),
  );

  sl.registerLazySingleton<CartRemoteDataSource>(
    () => CartRemoteDataSourceImpl(sl<ApiService>()),
  );

  // ---- Use cases ----
  sl.registerLazySingleton(() => GetAllCartsUseCase(sl<CartRepository>()));
  sl.registerLazySingleton(() => DeleteCartUseCase(sl<CartRepository>()));
  sl.registerLazySingleton(() => GetCartByIdUseCase(sl<CartRepository>()));
  sl.registerLazySingleton(() => CreateCartUseCase(sl<CartRepository>()));
  sl.registerLazySingleton(
    () => UpdateProductQuantityUseCase(sl<CartRepository>()),
  );
  sl.registerLazySingleton(
    () => RemoveProductFromCartUseCase(sl<CartRepository>()),
  );
  sl.registerLazySingleton(
    () => SeedInitialCartsIfEmptyUseCase(sl<CartRepository>()),
  );

  // ---- Blocs ----
  sl.registerFactory(
    () => CartsListBloc(
      getAllCartsUseCase: sl<GetAllCartsUseCase>(),
      createCartUseCase: sl<CreateCartUseCase>(),
      deleteCart: sl(),
    ),
  );

  sl.registerFactory<CartDetailsBloc>(
    () => CartDetailsBloc(
      getCartByIdUseCase: sl<GetCartByIdUseCase>(),
      updateProductQuantityUseCase: sl<UpdateProductQuantityUseCase>(),
      removeProductFromCartUseCase: sl<RemoveProductFromCartUseCase>(),
    ),
  );

  //========================profile====================
  // 1. Blocs
  sl.registerFactory(
    () => ProfileBloc(
      getProfileDetailsUseCase: sl(),
      getCachedProfileDetailsUseCase: sl(),
    ),
  );

  // 2. Use Cases
  sl.registerLazySingleton(() => GetProfileDetailsUseCase(sl()));
  sl.registerLazySingleton(() => CacheProfileDetailsUseCase(sl()));
  sl.registerLazySingleton(() => GetCachedProfileDetailsUseCase(sl()));

  // 3. Repository
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // 4. Data Sources
  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(apiService: sl()),
  );

  sl.registerLazySingleton<ProfileLocalDataSource>(
    () => ProfileLocalDataSourceImpl(appPreferences: sl()),
  );
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => InternetConnectionChecker.createInstance());
}
