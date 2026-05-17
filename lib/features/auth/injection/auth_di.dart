import '../../../core/cache/cache_helper.dart';
import '../../../core/network/network_info.dart';
import '../../../core/injection/core_di.dart';
import '../data/datasource/auth_remote_data_source/auth_remote_data_source.dart';
import '../data/datasource/auth_remote_data_source/auth_remote_data_source_imp.dart';
import '../data/repositories/auth_repository_imp.dart';
import '../domain/repositories/auth_repository.dart';
import '../domain/usecases/confirm_otp_usecase.dart';
import '../domain/usecases/get_current_user_usecase.dart';
import '../domain/usecases/send_phone_number_usecase.dart';
import '../domain/usecases/sign_out_usecase.dart';
import '../presentation/cubit/auth_cubit.dart';

void setupAuthDI() {
  // Data Source
  getIt.registerSingleton<AuthRemoteDataSource>(AuthRemoteDataSourceImp());

  // Repository
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImp(
      cacheHelper: getIt<CacheHelper>(),
      networkInfo: getIt<NetworkInfo>(),
      remoteDataSource: getIt<AuthRemoteDataSource>(),
    ),
  );

  // Use Cases
  getIt.registerLazySingleton<SendPhoneNumberUseCase>(
    () => SendPhoneNumberUseCase(authRepository: getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<ConfirmOtpUseCase>(
    () => ConfirmOtpUseCase(authRepository: getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<GetCurrentUserUseCase>(
    () => GetCurrentUserUseCase(authRepository: getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<SignOutUseCase>(
    () => SignOutUseCase(authRepository: getIt<AuthRepository>()),
  );

  //cubit
  getIt.registerLazySingleton<AuthCubit>(
    () => AuthCubit(
      sendPhoneNumberUseCase: getIt<SendPhoneNumberUseCase>(),
      confirmOtpUseCase: getIt<ConfirmOtpUseCase>(),
      getCurrentUserUseCase: getIt<GetCurrentUserUseCase>(),
      signOutUseCase: getIt<SignOutUseCase>(),
    ),
  );
}
