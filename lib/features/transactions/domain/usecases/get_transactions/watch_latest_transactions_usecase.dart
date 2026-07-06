import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failures/failure.dart';
import '../../entities/transactions_entity.dart';
import '../../repositories/transaction_repository.dart';
import 'get_transactions_params.dart';

class WatchLatestTransactionsUsecase {
  final TransactionRepository transactionRepository;
  const WatchLatestTransactionsUsecase({required this.transactionRepository});
  Stream<Either<Failure, List<TransactionEntity>>> call(
    GetTransactionsParams params,
  ) {
    return transactionRepository.watchLatestTransactions(params);
  }
}
