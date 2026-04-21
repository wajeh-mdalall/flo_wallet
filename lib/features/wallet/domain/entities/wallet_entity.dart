import 'package:equatable/equatable.dart';

class WalletEntity extends Equatable {
  final String uId;
  final String walletId;
  final int balance;
  final String currencyCode;
  final String currencySymbol;
  final DateTime createdAt;
  final DateTime lastUpdated;
  final bool isActive;

  const WalletEntity({
    required this.uId,
    required this.walletId,
    required this.balance,
    required this.currencyCode,
    required this.currencySymbol,
    required this.createdAt,
    required this.lastUpdated,
    required this.isActive,
  });

  @override
  List<Object?> get props => [
    uId,
    walletId,
    balance,
    currencyCode,
    currencySymbol,
    createdAt,
    lastUpdated,
    isActive,
  ];
}
