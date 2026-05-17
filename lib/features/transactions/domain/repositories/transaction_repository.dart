import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures/failure.dart';
import '../entities/transactions_entity.dart';
import '../usecases/get_transactions/get_transactions_params.dart';

abstract class TransactionRepository {
  Future<Either<Failure,List< TransactionEntity>>> getTransactions(
    GetTransactionsParams params,
  );
  // Future<Either<Failure, Unit>> addTransaction(TransactionEntity transaction);
  // Future<Either<Failure, TransactionEntity>> getTransactionDetails(
  //   String transactionId,
  // );
}
