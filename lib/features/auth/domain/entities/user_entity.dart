import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String uId;
  final String phoneNumber;
  final String displayName;
  final String? photoUrl;
  final DateTime createdAt;
  final bool isNewUser;

  const UserEntity({
    required this.uId,
    required this.phoneNumber,
    this.displayName = "",
    this.photoUrl,
    required this.createdAt,
    required this.isNewUser,
  });

  @override
  List<Object?> get props => [
    uId,
    phoneNumber,
    displayName,
    photoUrl,
    createdAt,
    isNewUser,
  ];
}
