import 'package:firebase_auth/firebase_auth.dart' as fb;
import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.uId,
    required super.phoneNumber,
    super.displayName,
    super.photoUrl,
    required super.createdAt,
    required super.isNewUser,
  });
  factory UserModel.fromFirebaseUser(fb.User user, {bool isNewUser = false}) {
    return UserModel(
      uId: user.uid,
      phoneNumber: user.phoneNumber ?? "",
      displayName: user.displayName ?? "",
      photoUrl: user.photoURL,
      createdAt: user.metadata.creationTime ?? DateTime.now(),
      isNewUser: isNewUser,
    );
  }
}
