import 'package:equatable/equatable.dart';

class SendMoneyParams extends Equatable {
  final String senderId;
  final String senderName;
  final String receiverId;
  final String receiverName;
  final int amount;
  final String? title;

  const SendMoneyParams({
    required this.senderId,
    required this.senderName,
    required this.receiverId,
    required this.receiverName,
    required this.amount,
     this.title,
  });

  @override
  List<Object?> get props => [
    senderId,
    senderName,
    receiverId,
    receiverName,
    amount,
    title,
  ];
}
