import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failures/failure.dart';
import '../../entities/transactions_entity.dart';
import '../../repositories/transaction_repository.dart';
import 'get_transactions_params.dart';

class GetTransactionsPaginatedUsecase {
  final TransactionRepository transactionRepository;

  const GetTransactionsPaginatedUsecase({required this.transactionRepository});
  Future<Either<Failure, List<TransactionEntity>>> call(
    GetTransactionsParams params,
  ) async {
    return await transactionRepository.getTransactionsPaginated(params);
  }
}
