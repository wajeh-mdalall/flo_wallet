import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flo_wallet/core/firestore_keys.dart';
import 'package:flo_wallet/core/errors/exceptions/firestore_exception.dart';
import 'package:flo_wallet/core/errors/failures/firestore_failure.dart';
import '../../../../../core/errors/handler/exception_handler.dart';
import '../../../../../core/services/fcm_http_service.dart';
import '../../../domain/entities/transactions_entity.dart';
import 'transaction_remote_data_source.dart';
import '../../models/transaction_model.dart';
import 'package:flo_wallet/core/extensions/firestore_map_extension.dart';

class TransactionRemoteDataSourceImp implements TransactionRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Stream<List<TransactionModel>> watchLatestTransactions({
    required String uId,
    required int limit,
  }) {
    return _firestore
        .collection(FirestoreCollections.transactions)
        .where(
          Filter.or(
            Filter(TransactionFirestoreKeys.senderId, isEqualTo: uId),
            Filter(TransactionFirestoreKeys.receiverId, isEqualTo: uId),
          ),
        )
        .orderBy(TransactionFirestoreKeys.timestamp, descending: true)
        .limit(limit)
        .snapshots()
        .map((querySnapshot) {
          return querySnapshot.docs.map((doc) {
            return TransactionModel.fromFirestore(
              jsonTransaction: doc.data(),
              docId: doc.id,
            );
          }).toList();
        })
        .handleError((e) {
          throw ExceptionHandler.handleFirestoreError(e);
        });
  }

  @override
  Future<void> sendMoney({
    required String senderId,
    required String senderName,
    required String receiverId,
    required String receiverName,
    required int amount,
    String? title,
  }) async {
    try {
      final senderWalletRef = _firestore
          .collection(FirestoreCollections.wallets)
          .doc(senderId);
      final receiverWalletRef = _firestore
          .collection(FirestoreCollections.wallets)
          .doc(receiverId);
      final transactionRef = _firestore
          .collection(FirestoreCollections.transactions)
          .doc();
      await _firestore.runTransaction((transaction) async {
        final senderSnapshot = await transaction.get(senderWalletRef);

        if (!senderSnapshot.exists) {
          throw FirestoreException(
            DocumentNotFoundFailure(
              "Sorry, an error occurred while initializing your financial account. Please contact technical support to reactivate your wallet.",
            ),
          );
        }
        final int currentSenderBalance = (senderSnapshot.data()!.toIntSafe(
          WalletFirestoreKeys.balance,
        ));

        if (currentSenderBalance < amount) {
          throw FirestoreException(InsufficientBalanceFailure());
        }
        final receiverSnapshot = await transaction.get(receiverWalletRef);

        if (!receiverSnapshot.exists) {
          throw FirestoreException(
            DocumentNotFoundFailure(
              "The QR code you scanned belongs to an inactive or non-existent account. Please verify the recipient's account.",
            ),
          );
        }
        final int currentReceiverBalance = (receiverSnapshot.data()!.toIntSafe(
          WalletFirestoreKeys.balance,
        ));
        transaction.update(senderWalletRef, {
          WalletFirestoreKeys.balance: currentSenderBalance - amount,
          WalletFirestoreKeys.lastUpdated: FieldValue.serverTimestamp(),
        });
        transaction.update(receiverWalletRef, {
          WalletFirestoreKeys.balance: currentReceiverBalance + amount,
          WalletFirestoreKeys.lastUpdated: FieldValue.serverTimestamp(),
        });
        final newTransaction = TransactionModel(
          id: transactionRef.id,
          status: TransactionStatus.success,
          amount: amount,
          timestamp: DateTime.now(),
          senderId: senderId,
          senderName: senderName,
          receiverId: receiverId,
          receiverName: receiverName,
          title: (title == null || title.isEmpty) ? "Money transfer" : title,
        );

        transaction.set(transactionRef, newTransaction.toJson());
      });
      _sendNotificationToReceiver(
        receiverId: receiverId,
        senderName: senderName,
        amount: amount,
      );
    } catch (e) {
      throw ExceptionHandler.handleFirestoreError(e);
    }
  }

  Future<void> _sendNotificationToReceiver({
    required String receiverId,
    required String senderName,
    required int amount,
  }) async {
    try {
      final receiverDoc = await _firestore
          .collection(FirestoreCollections.users)
          .doc(receiverId)
          .get();
      final String? receiverToken = receiverDoc.data()?[UserFirestoreKeys.fcmToken];

      if (receiverToken != null && receiverToken.isNotEmpty) {
        await FcmHttpService.sendTransferNotification(
          receiverFcmToken: receiverToken,
          senderName: senderName,
          amount: amount,
        );
      }
    } catch (_) {}
  }

  @override
  Future<List<TransactionModel>> getTransactionsPaginated({
    required String uId,
    required int limit,
    String? lastTransactionId,
  }) async {
    try {
      var query = _firestore
          .collection(FirestoreCollections.transactions)
          .where(
            Filter.or(
              Filter(TransactionFirestoreKeys.senderId, isEqualTo: uId),
              Filter(TransactionFirestoreKeys.receiverId, isEqualTo: uId),
            ),
          )
          .orderBy(TransactionFirestoreKeys.timestamp, descending: true)
          .limit(limit);
      if (lastTransactionId != null) {
        final lastDocSnapshot = await _firestore
            .collection(FirestoreCollections.transactions)
            .doc(lastTransactionId)
            .get();
        if (lastDocSnapshot.exists) {
          query = query.startAfterDocument(lastDocSnapshot);
        }
      }

      final querySnapshot = await query.get();

      return querySnapshot.docs.map((doc) {
        return TransactionModel.fromFirestore(
          jsonTransaction: doc.data(),
          docId: doc.id,
        );
      }).toList();
    } catch (e) {
      throw ExceptionHandler.handleFirestoreError(e);
    }
  }
}
