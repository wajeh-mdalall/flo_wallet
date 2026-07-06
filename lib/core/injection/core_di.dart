import 'package:flo_wallet/core/theme/cubit/theme_cubit.dart';

import '../helper/image_upload_helper.dart';

import '../network/network_info.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../cache/cache_helper.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;
void setupCoreDI() {
  getIt.registerSingleton<CacheHelper>(CacheHelper());
  getIt.registerLazySingleton<InternetConnectionChecker>(
    () => InternetConnectionChecker.instance,
  );
  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(getIt<InternetConnectionChecker>()),
  );
  getIt.registerLazySingleton<ImageUploadHelper>(() => ImageUploadHelperImp());
  getIt.registerLazySingleton<ThemeCubit>(() => ThemeCubit());

}
