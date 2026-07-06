import '../../models/transaction_model.dart';

abstract class TransactionRemoteDataSource {
  Stream<List<TransactionModel>> watchLatestTransactions({
    required String uId,
    required int limit,
  });
  Future<List<TransactionModel>> getTransactionsPaginated({
    required String uId,
    required int limit,
    String? lastTransactionId,
  });
  Future<void> sendMoney({
    required String senderId,
    required String senderName,
    required String receiverId,
    required String receiverName,
    required int amount,
     String? title,
  });
}
