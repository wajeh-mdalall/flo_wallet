abstract class FirestoreCollections {
  static const String wallets = "wallets";
  static const String users = "users";
  static const String transactions = "transactions";
}

abstract class TransactionFirestoreKeys {
  static const String id = 'id';
  static const String type = 'type';
  static const String status = 'status';
  static const String amount = 'amount';
  static const String timestamp = 'timestamp';
  static const String senderId = 'senderId';
  static const String senderName = 'senderName';
  static const String receiverId = 'receiverId';
  static const String receiverName = 'receiverName';
  static const String title = 'title';
}

abstract class WalletFirestoreKeys {
  static const String uId = "uId";
  static const String walletId = "walletId";
  static const String balance = "balance";
  static const String currencyCode = "currencyCode";
  static const String currencySymbol = "currencySymbol";
  static const String createdAt = "createdAt";
  static const String lastUpdated = "lastUpdated";
  static const String isActive = "isActive";
}

abstract class UserFirestoreKeys {
  static const String uId = "uId";
  static const String phoneNumber = "phoneNumber";
  static const String name = "name";
  static const String profileImageUrl = "profileImageUrl";
  static const String dateOfBirth = "dateOfBirth";
  static const String country = "country";
}
