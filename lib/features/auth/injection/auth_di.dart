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
  getIt.registerSingleton<AuthRemoteDataSource>(AuthRemoteDataSourceImp());

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImp(
      cacheHelper: getIt<CacheHelper>(),
      networkInfo: getIt<NetworkInfo>(),
      remoteDataSource: getIt<AuthRemoteDataSource>(),
    ),
  );
  getIt.registerLazySingleton<SendPhoneNumberUseCase>(
    () => SendPhoneNumberUseCase(authRepositories: getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<ConfirmOtpUseCase>(
    () => ConfirmOtpUseCase(authRepositories: getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<GetCurrentUserUseCase>(
    () => GetCurrentUserUseCase(authRepositories: getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<SignOutUseCase>(
    () => SignOutUseCase(authRepositories: getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<AuthCubit>(
    () => AuthCubit(
      sendPhoneNumberUseCase: getIt<SendPhoneNumberUseCase>(),
      confirmOtpUseCase: getIt<ConfirmOtpUseCase>(),
      getCurrentUserUseCase: getIt<GetCurrentUserUseCase>(),
      signOutUseCase: getIt<SignOutUseCase>(),
    ),
  );
}