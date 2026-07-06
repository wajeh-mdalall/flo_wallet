import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failures/failure.dart';
import '../../repositories/transaction_repository.dart';
import 'send_money_params.dart';

class SendMoneyUsecase {
  final TransactionRepository transactionRepository;

  const SendMoneyUsecase({required this.transactionRepository});
  Future<Either<Failure, Unit>> call(SendMoneyParams params) async {
    return await transactionRepository.sendMoney(params);
  }
}
