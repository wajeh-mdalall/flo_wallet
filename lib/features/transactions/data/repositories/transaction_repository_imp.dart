import 'package:dartz/dartz.dart';
import 'package:flo_wallet/features/transactions/domain/usecases/send_money/send_money_params.dart';
import '../../../../core/errors/failures/failure.dart';
import '../../../../core/errors/handler/exception_handler.dart';
import '../datasource/transaction_remote_data_source/transaction_remote_data_source.dart';
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
  Stream<Either<Failure, List<TransactionEntity>>> watchLatestTransactions(
    GetTransactionsParams params,
  ) async* {
    yield* remoteDataSource
        .watchLatestTransactions(uId: params.uId, limit: params.limit)
        .map<Either<Failure, List<TransactionEntity>>>(
          (transactions) => right(transactions),
        )
        .handleError((e) {
          return left(ExceptionHandler.exceptionToFailure(e));
        });
  }

  @override
  Future<Either<Failure, Unit>> sendMoney(SendMoneyParams params) async {
    if (!await networkInfo.isConnected) {
      return left(OfflineFailure());
    }
    try {
      await remoteDataSource.sendMoney(
        senderId: params.senderId,
        senderName: params.senderName,
        receiverId: params.receiverId,
        receiverName: params.receiverName,
        amount: params.amount,
        title: params.title,
      );
      return right(unit);
    } catch (e) {
      return left(ExceptionHandler.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<TransactionEntity>>> getTransactionsPaginated(
    GetTransactionsParams params,
  ) async {
    if (!await networkInfo.isConnected) {
      return left(OfflineFailure());
    }
    try {
      final List<TransactionEntity> transactions = await remoteDataSource
          .getTransactionsPaginated(
            uId: params.uId,
            limit: params.limit,
            lastTransactionId: params.lastTransactionId,
          );
      return right(transactions);
    } catch (e) {
      return left(ExceptionHandler.exceptionToFailure(e));
    }
  }
}
