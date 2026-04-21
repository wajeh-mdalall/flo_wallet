import 'package:flo_wallet/features/transactions/domain/entities/transactions_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flo_wallet/core/extensions/firestore_map_extension.dart';
import 'package:flo_wallet/features/transactions/transaction_firestore_keys.dart';

class TransactionModel extends TransactionEntity {
  const TransactionModel({
    required super.id,
    required super.type,
    required super.status,
    required super.amount,
    required super.timestamp,
    required super.senderId,
    required super.senderName,
    required super.receiverId,
    required super.receiverName,
    required super.title,
  });

  factory TransactionModel.fromJson({
    required Map<String, dynamic> jsonTransaction,
    required String docId,
  }) {
    return TransactionModel(
      id: docId,
      type: jsonTransaction.toTransactionType(TransactionFirestoreKeys.type),
      status: jsonTransaction.toTransactionStatus(
        TransactionFirestoreKeys.status,
      ),
      amount: jsonTransaction.toIntSafe(TransactionFirestoreKeys.amount),
      timestamp: jsonTransaction.toDateTime(TransactionFirestoreKeys.timestamp),
      senderId: jsonTransaction[TransactionFirestoreKeys.senderId] as String?,
      senderName:
          jsonTransaction[TransactionFirestoreKeys.senderName] as String?,
      receiverId:
          jsonTransaction[TransactionFirestoreKeys.receiverId] as String?,
      receiverName:
          jsonTransaction[TransactionFirestoreKeys.receiverName] as String?,
      title: jsonTransaction[TransactionFirestoreKeys.title] as String? ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      TransactionFirestoreKeys.type: type.name,
      TransactionFirestoreKeys.status: status.name,
      TransactionFirestoreKeys.amount: amount,
      TransactionFirestoreKeys.timestamp: Timestamp.fromDate(timestamp),
      TransactionFirestoreKeys.senderId: senderId,
      TransactionFirestoreKeys.senderName: senderName,
      TransactionFirestoreKeys.receiverId: receiverId,
      TransactionFirestoreKeys.receiverName: receiverName,
      TransactionFirestoreKeys.title: title,
    };
  }
}
