import '../../../core/injection/core_di.dart';
import '../../../core/network/network_info.dart';

import '../data/datasource/wallet_remote_data_source/wallet_remote_data_source.dart';
import '../data/datasource/wallet_remote_data_source/wallet_remote_data_source_imp.dart';
import '../data/repositories/wallet_repository_imp.dart';
import '../domain/repositories/wallet_repository.dart';
import '../domain/usecases/create_wallet_usecase.dart';
import '../domain/usecases/get_wallet_usecase.dart';
import '../presentation/cubit/wallet_cubit.dart';

void setupWalletDI() {
  // Data Source
  getIt.registerLazySingleton<WalletRemoteDataSource>(
    () => WalletRemoteDataSourceImp(),
  );

  // Repository
  getIt.registerLazySingleton<WalletRepository>(
    () => WalletRepositoryImp(
      remoteDataSource: getIt<WalletRemoteDataSource>(),
      networkInfo: getIt<NetworkInfo>(),
    ),
  );

  // Use Cases
  getIt.registerLazySingleton(
    () => CreateWalletUsecase(walletRepository: getIt<WalletRepository>()),
  );
  getIt.registerLazySingleton(
    () => GetWalletUsecase(walletRepository: getIt<WalletRepository>()),
  );

  //cubit
  getIt.registerFactory(
    () => WalletCubit(
      createWalletUsecase: getIt<CreateWalletUsecase>(),
      getWalletUsecase: getIt<GetWalletUsecase>(),
    ),
  );
}
