import 'package:dartz/dartz.dart';
import 'package:flo_wallet/core/errors/failures/failure.dart';
import 'package:flo_wallet/core/errors/handler/exception_handler.dart';
import 'package:flo_wallet/features/transactions/data/datasource/transaction_remote_data_source/transaction_remote_data_source.dart';
import 'package:flo_wallet/features/transactions/data/models/transaction_model.dart';
// import 'package:flo_wallet/core/network/network_info.dart';
import 'package:flo_wallet/features/transactions/domain/entities/transactions_entity.dart';
import 'package:flo_wallet/features/transactions/domain/repositories/transaction_repository.dart';
import 'package:flo_wallet/features/transactions/domain/usecases/get_transactions/get_transactions_params.dart';
import '../../../../core/network/network_info.dart';

class TransactionRepositoryImp implements TransactionRepository {
  final TransactionRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  TransactionRepositoryImp({
    required this.remoteDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, List<TransactionEntity>>> getTransactions(
    GetTransactionsParams params,
  ) async {
    if (!await networkInfo.isConnected) {
      return left(OfflineFailure());
    }
    try {
      final List<TransactionModel> transactions = await remoteDataSource
          .getTransactions(userId: params.userId, limit: params.limit ?? 20);
      return right(transactions);
    } catch (e) {
      return left(ExceptionHandler.exceptionToFailure(e));
    }
  }
}
