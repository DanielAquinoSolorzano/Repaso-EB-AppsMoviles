import 'dart:collection';

import 'package:book_app/core/database/app_database.dart';
import 'package:book_app/core/storage/token_storage.dart';
import 'package:book_app/features/auth/data/remote/auth_service.dart';
import 'package:book_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:book_app/features/auth/domain/auth_repository.dart';
import 'package:book_app/features/auth/presentation/login_view_model.dart';
import 'package:book_app/features/home/data/local/book_dao.dart';
import 'package:book_app/features/home/data/remote/book_service.dart';
import 'package:book_app/features/home/data/repositories/book_repository_impl.dart';
import 'package:book_app/features/home/domain/book_repository.dart';
import 'package:book_app/features/home/presentation/home_view_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerLazySingleton<AppDatabase>(() => AppDatabase());

  getIt.registerLazySingleton<BookDao>(
    () => BookDao(appDatabase: getIt<AppDatabase>()),
  );

  getIt.registerLazySingleton<BookService>(() => BookService());

  getIt.registerLazySingleton<BookRepository>(
    () => BookRepositoryImpl(
      service: getIt<BookService>(),
      dao: getIt<BookDao>(),
    ),
  );

  getIt.registerFactory<HomeViewModel>(
    () => HomeViewModel(repository: getIt<BookRepository>()),
  );



/////////////////////////////////////////////////
  getIt.registerLazySingleton<FlutterSecureStorage>(() => FlutterSecureStorage());


  getIt.registerLazySingleton<TokenStorage>(() => TokenStorage(
    storage: getIt<FlutterSecureStorage>()
  ));

  getIt.registerLazySingleton<AuthService>(() => AuthService());


  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      service: getIt<AuthService>(),
      tokenStorage: getIt<TokenStorage>(),
    ),
  );

  getIt.registerFactory<LoginViewModel>(
    () => LoginViewModel(repository: getIt<AuthRepository>()),
  );
}
