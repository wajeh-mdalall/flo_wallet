import 'package:flo_wallet/features/transactions/presentation/cubit/transactions_cubit.dart';

import '../../../core/injection/core_di.dart';
import '../../../core/network/network_info.dart';
import '../data/datasource/transaction_remote_data_source/transaction_remote_data_source.dart';
import '../data/datasource/transaction_remote_data_source/transaction_remote_data_source_imp.dart';
import '../data/repositories/transaction_repository_imp.dart';
import '../domain/repositories/transaction_repository.dart';
import '../domain/usecases/get_transactions/get_transactions_usecase.dart';
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
    () => GetTransactionsUsecase(
      transactionRepository: getIt<TransactionRepository>(),
    ),
  );

  // Cubit
  getIt.registerFactory(
    () => TransactionsCubit(getTransactionsUsecase: getIt<GetTransactionsUsecase>()),
  );
}
