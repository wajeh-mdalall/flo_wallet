import 'package:flo_wallet/core/helper/image_upload_helper.dart';
import 'package:flo_wallet/features/user/domain/usecases/find_user_by_phone_usecase.dart';
import 'package:flo_wallet/features/user/domain/usecases/update_fcm_token_usecase.dart';
import 'package:flo_wallet/features/user/domain/usecases/upload_profile_image_usecase.dart';
import 'package:flo_wallet/features/user/presentation/cubit/user_profile_management_cubit/user_profile_management_cubit.dart';
import 'package:flo_wallet/features/wallet/domain/usecases/create_wallet_usecase.dart';
import '../../../core/injection/core_di.dart';
import '../../../core/network/network_info.dart';
import '../data/datasource/user_remote_data_source.dart';
import '../data/datasource/user_remote_data_source_imp.dart';
import '../data/repositories/user_repository_imp.dart';
import '../domain/repositories/user_repository.dart';
import '../domain/usecases/get_user_data_usecase.dart';
import '../domain/usecases/update_profile_usecase.dart';
import '../domain/usecases/upload_user_data_usecase.dart';
import '../presentation/cubit/user_search_cubit/user_search_cubit.dart';

void setupUserDI() {
  // Data Source
  getIt.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImp(),
  );

  // Repository
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImp(
      imageUploadHelper: getIt<ImageUploadHelper>(),
      remoteDataSource: getIt<UserRemoteDataSource>(),
      networkInfo: getIt<NetworkInfo>(),
    ),
  );

  // Use Cases
  getIt.registerLazySingleton(
    () => GetUserDataUsecase(userRepository: getIt<UserRepository>()),
  );
  getIt.registerLazySingleton(
    () => UploadUserDataUsecase(userRepository: getIt<UserRepository>()),
  );
  getIt.registerLazySingleton(
    () => UploadProfileImageUsecase(userRepository: getIt<UserRepository>()),
  );
  getIt.registerLazySingleton(
    () => UpdateProfileUsecase(userRepository: getIt<UserRepository>()),
  );
  getIt.registerLazySingleton(
    () => FindUserByPhoneUsecase(userRepository: getIt<UserRepository>()),
  );
    getIt.registerLazySingleton(
    () => UpdateFcmTokenUsecase(userRepository: getIt<UserRepository>()),
  );

  // Cubit
  getIt.registerFactory(
    () => UserProfileManagementCubit(
      uploadUserDataUsecase: getIt<UploadUserDataUsecase>(),
      uploadProfileImageUsecase: getIt<UploadProfileImageUsecase>(),
      createWalletUsecase: getIt<CreateWalletUsecase>(),
      updateProfileUsecase: getIt<UpdateProfileUsecase>(),
    ),
  );
  getIt.registerFactory(
    () => UserSearchCubit(
      findUserByPhoneUsecase: getIt<FindUserByPhoneUsecase>(),
    ),
  );
}
