import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../../core/errors/handler/exception_handler.dart';
import 'transaction_remote_data_source.dart';
import '../../models/transaction_model.dart';
import '../../../transaction_firestore_keys.dart';

class TransactionRemoteDataSourceImp implements TransactionRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Future<List<TransactionModel>> getTransactions({
    required String uId,
    required int limit,
  }) async {
    try {
      final querySnapshot = await _firestore
          .collection(TransactionFirestoreKeys.collectionName)
          .where(
            Filter.or(
              Filter(TransactionFirestoreKeys.senderId, isEqualTo: uId),
              Filter(TransactionFirestoreKeys.receiverId, isEqualTo: uId),
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
