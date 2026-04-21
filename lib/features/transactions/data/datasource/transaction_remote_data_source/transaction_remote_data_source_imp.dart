import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flo_wallet/core/errors/handler/exception_handler.dart';
import 'package:flo_wallet/features/transactions/data/datasource/transaction_remote_data_source/transaction_remote_data_source.dart';
import 'package:flo_wallet/features/transactions/data/models/transaction_model.dart';
import 'package:flo_wallet/features/transactions/transaction_firestore_keys.dart';

class TransactionRemoteDataSourceImp implements TransactionRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Future<List<TransactionModel>> getTransactions({
    required String userId,
    required int limit,
  }) async {
    try {
      final querySnapshot = await _firestore
          .collection(TransactionFirestoreKeys.collectionName)
          .where(
            Filter.or(
              Filter(TransactionFirestoreKeys.senderId, isEqualTo: userId),
              Filter(TransactionFirestoreKeys.receiverId, isEqualTo: userId),
            ),
          )
          .orderBy(TransactionFirestoreKeys.timestamp, descending: true)
          .limit(limit)
          .get();

      return querySnapshot.docs.map((doc) {
        return TransactionModel.fromJson(
          jsonTransaction: doc.data(),
          docId: doc.id,
        );
      }).toList();
    } catch (e) {
      throw ExceptionHandler.handleFirestoreError(e);
    }
  }
}
