import 'package:equatable/equatable.dart';

class TransactionEntity extends Equatable {
  final String id;
  final TransactionType type;
  final TransactionStatus status;
  final int amount;
  final DateTime timestamp;
  final String? senderId;
  final String? senderName;
  final String? receiverId;
  final String? receiverName;
  final String title;

  const TransactionEntity({
    required this.id,
    required this.type,
    required this.status,
    required this.amount,
    required this.timestamp,
    required this.senderId,
    required this.senderName,
    required this.receiverId,
    required this.receiverName,
    required this.title,
  });

  @override
  List<Object?> get props => [
    id,
    type,
    status,
    amount,
    timestamp,
    senderId,
    senderName,
    receiverId,
    receiverName,
    title,
  ];
}

enum TransactionStatus { success, pending, failure, cancelled }

enum TransactionType {
  transferSent,
  transferReceived,
  withdrawal,
  deposit,
  payment,
  refund,
}
