import 'package:dartz/dartz.dart';
import 'package:flo_wallet/core/errors/failures/failure.dart';
import 'package:flo_wallet/features/transactions/domain/entities/transactions_entity.dart';
import 'package:flo_wallet/features/transactions/domain/usecases/get_transactions/get_transactions_params.dart';

abstract class TransactionRepository {
  Future<Either<Failure,List< TransactionEntity>>> getTransactions(
    GetTransactionsParams params,
  );
  // Future<Either<Failure, Unit>> addTransaction(TransactionEntity transaction);
  // Future<Either<Failure, TransactionEntity>> getTransactionDetails(
  //   String transactionId,
  // );
}
