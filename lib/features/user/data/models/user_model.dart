import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flo_wallet/core/firestore_keys.dart';
import '../../../../core/extensions/firestore_map_extension.dart';
import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.uId,
    required super.phoneNumber,
    required super.name,
    super.profileImageUrl,
    required super.dateOfBirth,
    required super.country,
  });

  factory UserModel.fromFirestore(Map<String, dynamic> jsonUser) {
    return UserModel(
      uId: jsonUser[UserFirestoreKeys.uId] as String? ?? "",
      phoneNumber: jsonUser[UserFirestoreKeys.phoneNumber] as String? ?? "",
      name: jsonUser[UserFirestoreKeys.name] as String? ?? "",
      profileImageUrl: jsonUser[UserFirestoreKeys.profileImageUrl] as String?,
      dateOfBirth: jsonUser.toDateTime(UserFirestoreKeys.dateOfBirth),
      country: jsonUser[UserFirestoreKeys.country] as String? ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      UserFirestoreKeys.uId: uId,
      UserFirestoreKeys.phoneNumber: phoneNumber,
      UserFirestoreKeys.name: name,
      UserFirestoreKeys.profileImageUrl: profileImageUrl,
      UserFirestoreKeys.dateOfBirth: Timestamp.fromDate(dateOfBirth),
      UserFirestoreKeys.country: country,
    };
  }
}
