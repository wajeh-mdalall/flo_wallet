import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flo_wallet/features/transactions/domain/entities/transactions_entity.dart';

extension FirestoreMapExtension on Map<String, dynamic> {
  // 1. Convert Timestamp to DateTime
  DateTime toDateTime(String key) {
    final value = this[key];
    if (value is Timestamp) {
      return value.toDate();
    }
    return DateTime.now();
  }

  // 2. Safely convert num to int
  int toIntSafe(String key) {
    final value = this[key];
    if (value is num) {
      return value.toInt();
    }
    return 0;
  }

  // 3. Convert String to TransactionType Enum
  TransactionType toTransactionType(String key) {
    final value = this[key] as String?;
    return TransactionType.values.firstWhere(
      (e) => e.name == value,
      orElse: () => TransactionType.payment,
    );
  }

  // 4. Convert String to TransactionStatus Enum
  TransactionStatus toTransactionStatus(String key) {
    final value = this[key] as String?;
    return TransactionStatus.values.firstWhere(
      (e) => e.name == value,
      orElse: () => TransactionStatus.pending,
    );
  }
}
