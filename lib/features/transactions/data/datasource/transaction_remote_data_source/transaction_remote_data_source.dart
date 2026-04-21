import 'package:flo_wallet/features/transactions/data/models/transaction_model.dart';

abstract class TransactionRemoteDataSource {
  Future<List<TransactionModel>> getTransactions({
    required String userId,
    required int limit,
  });
}
