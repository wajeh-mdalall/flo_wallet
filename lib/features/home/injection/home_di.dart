import 'package:flo_wallet/core/injection/core_di.dart';
import 'package:flo_wallet/features/home/presentation/cubit/home_cubit.dart';
import 'package:flo_wallet/features/transactions/domain/usecases/get_transactions/watch_latest_transactions_usecase.dart';
import 'package:flo_wallet/features/user/domain/usecases/get_user_data_usecase.dart';
import 'package:flo_wallet/features/wallet/domain/usecases/get_wallet_usecase.dart';

void setupHomeDI() {
  // cubit
  getIt.registerLazySingleton<HomeCubit>(
    () => HomeCubit(
      getUserDataUsecase: getIt<GetUserDataUsecase>(),
      watchWalletUsecase: getIt<WatchWalletUsecase>(),
      watchLatestTransactionsUsecase: getIt<WatchLatestTransactionsUsecase>(),
    ),
  );
}
