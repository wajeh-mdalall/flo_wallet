import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures/failure.dart';
import '../entities/transactions_entity.dart';
import '../usecases/get_transactions/get_transactions_params.dart';
import '../usecases/send_money/send_money_params.dart';

abstract class TransactionRepository {
  Stream<Either<Failure, List<TransactionEntity>>> watchLatestTransactions(
    GetTransactionsParams params,
  );
  Future<Either<Failure, List<TransactionEntity>>> getTransactionsPaginated(
    GetTransactionsParams params,
  );
  Future<Either<Failure, Unit>> sendMoney(SendMoneyParams params);
}
