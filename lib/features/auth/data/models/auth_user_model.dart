import 'package:firebase_auth/firebase_auth.dart' as fb;
import '../../domain/entities/auth_user_entity.dart';

class AuthUserModel extends AuthUserEntity {
  const AuthUserModel({
    required super.uId,
    required super.phoneNumber,
    required super.isNewUser,
  });
  factory AuthUserModel.fromFirebaseUser(
    fb.User user, {
    bool isNewUser = false,
  }) {
    return AuthUserModel(
      uId: user.uid,
      phoneNumber: user.phoneNumber ?? "",
      isNewUser: isNewUser,
    );
  }
}
