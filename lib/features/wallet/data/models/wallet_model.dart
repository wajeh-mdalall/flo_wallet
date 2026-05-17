import '../../../../core/extensions/firestore_map_extension.dart';
import '../../wallet_firestore_keys.dart';
import '../../domain/entities/wallet_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WalletModel extends WalletEntity {
  const WalletModel({
    required super.uId,
    required super.walletId,
    required super.balance,
    required super.currencyCode,
    required super.currencySymbol,
    required super.createdAt,
    required super.lastUpdated,
    required super.isActive,
  });
  factory WalletModel.initial(String uId) {
    return WalletModel(
      uId: uId,
      walletId: uId,
      balance: 0,
      currencyCode: "USD",
      currencySymbol: "\$",
      createdAt: DateTime.now(),
      lastUpdated: DateTime.now(),
      isActive: true,
    );
  }
  factory WalletModel.fromJson({required Map<String, dynamic> jsonWallet}) {
    return WalletModel(
      uId: jsonWallet[WalletFirestoreKeys.uId] as String? ?? "",
      walletId: jsonWallet[WalletFirestoreKeys.walletId] as String? ?? "",
      balance: jsonWallet.toIntSafe(WalletFirestoreKeys.balance),
      currencyCode:
          jsonWallet[WalletFirestoreKeys.currencyCode] as String? ?? "USD",
      currencySymbol:
          jsonWallet[WalletFirestoreKeys.currencySymbol] as String? ?? "\$",
      createdAt: jsonWallet.toDateTime(WalletFirestoreKeys.createdAt),
      lastUpdated: jsonWallet.toDateTime(WalletFirestoreKeys.lastUpdated),
      isActive: (jsonWallet[WalletFirestoreKeys.isActive] as bool?) ?? true,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      WalletFirestoreKeys.uId: uId,
      WalletFirestoreKeys.walletId: walletId,
      WalletFirestoreKeys.balance: balance,
      WalletFirestoreKeys.currencyCode: currencyCode,
      WalletFirestoreKeys.currencySymbol: currencySymbol,
      WalletFirestoreKeys.createdAt: Timestamp.fromDate(createdAt),
      WalletFirestoreKeys.lastUpdated: Timestamp.fromDate(lastUpdated),
      WalletFirestoreKeys.isActive: isActive,
    };
  }
}
