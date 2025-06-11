import 'package:boilerplate/core/core.dart';
import 'package:boilerplate/features/features.dart';
import 'package:boilerplate/utils/utils.dart';
import 'package:get_it/get_it.dart';

GetIt sl = GetIt.instance;

Future<void> serviceLocator({
  bool isUnitTest = false,
  bool isDBEnable = true,
  String prefixBox = '',
}) async {
  /// For unit testing only
  if (isUnitTest) {
    await sl.reset();
  }
  sl.registerSingleton<DioClient>(DioClient(isUnitTest: isUnitTest));
  _dataSources();
  _repositories();
  _useCase();
  _cubit();
  if (isDBEnable) {
    await _initObjectBox(
      isUnitTest: isUnitTest,
      prefixBox: prefixBox,
    );
  }
}

Future<void> _initObjectBox({
  bool isUnitTest = false,
  String prefixBox = '',
}) async {
  await MainBoxMixin.initObjectBox(prefixBox);
  sl.registerSingleton<MainBoxMixin>(MainBoxMixin());
}

/// Register repositories
void _repositories() {
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton<GeneralRepository>(
    () => GeneralRepositoryImpl(sl()),
  );
}

/// Register dataSources
void _dataSources() {
  sl.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(sl()),
  );

  sl.registerLazySingleton<GeneralRemoteDatasource>(
    () => GeneralRemoteDatasourceImpl(sl()),
  );
}

void _useCase() {
  /// Auth
  sl.registerLazySingleton(() => PostLoginUsecase(sl()));
  sl.registerLazySingleton(() => PostRegister(sl()));

  // General
  sl.registerLazySingleton(() => CheckAppVersionUsecase(sl()));
}

void _cubit() {
  /// Auth
  sl.registerFactory(() => RegisterCubit(sl()));
  sl.registerFactory(() => AuthCubit(sl()));

  // General
  sl.registerFactory(() => MainCubit());
  sl.registerFactory(() => AppVersionCubit(sl()));
  sl.registerFactory(() => SettingsCubit());
}
