import 'package:equatable/equatable.dart';

class AuthUserEntity extends Equatable {
  final String uId;
  final String phoneNumber;
  final bool isNewUser;

  const AuthUserEntity({
    required this.uId,
    required this.phoneNumber,
    required this.isNewUser,
  });

  @override
  List<Object?> get props => [uId, phoneNumber, isNewUser];
}
