// مسیر: lib/injection_container.dart

// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:dio/dio.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';
// import 'package:persian_quote/data/services/network_service.dart'
//     show NetworkService;
import 'package:get_it/get_it.dart';
import 'package:persian_quote/core/config/app_config.dart' show AppConfig;
import 'package:persian_quote/core/database/database_helper.dart'
    show DatabaseHelper;
import 'package:persian_quote/data/repositories/quote_repository_impl.dart';
import 'package:persian_quote/data/sources/contract.dart';
import 'package:persian_quote/data/sources/local/quote_local_datasource.dart';
import 'package:persian_quote/data/sources/local/quote_local_datasource_dev.dart'
    show QuoteLocalDataSourceDevImpl;
import 'package:persian_quote/domain/repositories/quote_repository.dart';
import 'package:persian_quote/domain/usecase/quote_update.dart'
    show ChangeQuoteUseCase;
import 'package:persian_quote/domain/usecase/show_quotes.dart'
    show GetProductsUseCase;
import 'package:persian_quote/presentation/cubits/quote_cubit.dart'
    show QuoteCubit;
import 'package:persian_quote/presentation/cubits/theme_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart' show Database;

final sl = GetIt.instance;

Future<void> init() async {
  AppConfig.init();

  if (AppConfig.isDevMode) {
    sl.registerLazySingleton<QuoteLocalDataSource>(
      () => QuoteLocalDataSourceDevImpl(),
    );
  } else {
    final database = await DatabaseHelper.initDatabase();
    sl.registerSingleton<Database>(database);

    sl.registerLazySingleton<QuoteLocalDataSource>(
      () => QuoteLocalDataSourceImpl(sl<Database>()),
    );
  }

  sl.registerFactory(() => QuoteCubit(sl(), sl()));
  sl.registerFactory(() => ThemeCubit(sl()));

  sl.registerLazySingleton(() => ChangeQuoteUseCase(sl()));
  sl.registerLazySingleton(() => GetProductsUseCase(sl()));
  // sl.registerLazySingleton(() => NetworkService(sl(), sl()));

  sl.registerLazySingleton<QuoteRepository>(
    () => QuoteRepositoryImpl(localDataSource: sl()),
  );

  // sl.registerLazySingleton(() => Dio());

  // sl.registerLazySingleton(() => Connectivity());

  final prefs = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(prefs);

  // sl.registerLazySingleton(() => InternetConnectionChecker.createInstance());
}
