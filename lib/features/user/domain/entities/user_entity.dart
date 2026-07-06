import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String uId;
  final String phoneNumber;
  final String name;
  final String? profileImageUrl;
  final DateTime dateOfBirth;
  final String country;

  const UserEntity({
    required this.uId,
    required this.phoneNumber,
    required this.name,
    this.profileImageUrl,
    required this.dateOfBirth,
    required this.country,
  });

  @override
  List<Object?> get props => [
    uId,
    phoneNumber,
    name,
    profileImageUrl,
    dateOfBirth,
    country,
  ];
}
