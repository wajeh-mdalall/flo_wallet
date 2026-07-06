import 'package:flo_wallet/features/transactions/domain/usecases/get_transactions/get_transactions_paginated_usecase.dart';
import 'package:flo_wallet/features/transactions/domain/usecases/send_money/send_money_usecase.dart';
import 'package:flo_wallet/features/transactions/presentation/cubit/transactions_cubit/transactions_cubit.dart';

import '../presentation/cubit/send_money_cubit/send_money_cubit.dart';
import '../../../core/injection/core_di.dart';
import '../../../core/network/network_info.dart';
import '../data/datasource/transaction_remote_data_source/transaction_remote_data_source.dart';
import '../data/datasource/transaction_remote_data_source/transaction_remote_data_source_imp.dart';
import '../data/repositories/transaction_repository_imp.dart';
import '../domain/repositories/transaction_repository.dart';
import '../domain/usecases/get_transactions/watch_latest_transactions_usecase.dart';
// import '../presentation/cubit/transaction_cubit.dart';

void setupTransactionDI() {
  // Data Source
  getIt.registerLazySingleton<TransactionRemoteDataSource>(
    () => TransactionRemoteDataSourceImp(),
  );

  // Repository
  getIt.registerLazySingleton<TransactionRepository>(
    () => TransactionRepositoryImp(
      remoteDataSource: getIt<TransactionRemoteDataSource>(),
      networkInfo: getIt<NetworkInfo>(),
    ),
  );

  // Use Case
  getIt.registerLazySingleton(
    () => WatchLatestTransactionsUsecase(
      transactionRepository: getIt<TransactionRepository>(),
    ),
  );
  getIt.registerLazySingleton(
    () =>
        SendMoneyUsecase(transactionRepository: getIt<TransactionRepository>()),
  );
  getIt.registerLazySingleton(
    () => GetTransactionsPaginatedUsecase(
      transactionRepository: getIt<TransactionRepository>(),
    ),
  );

  // Cubit
  getIt.registerFactory(
    () => SendMoneyCubit(sendMoneyUsecase: getIt<SendMoneyUsecase>()),
  );
  getIt.registerFactory(
    () => TransactionsCubit(
      getTransactionsPaginatedUsecase: getIt<GetTransactionsPaginatedUsecase>(),
    ),
  );
}
