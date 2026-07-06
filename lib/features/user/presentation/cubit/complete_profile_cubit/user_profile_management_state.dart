part of 'user_profile_management_cubit.dart';

sealed class UserProfileManagementState extends Equatable {
  const UserProfileManagementState();

  @override
  List<Object?> get props => [];
}

final class UserProfileManagementInitial extends UserProfileManagementState {}

final class UserProfileManagementLoading extends UserProfileManagementState {}

final class ProfileSetupSuccess extends UserProfileManagementState {}
final class ProfileUpdateSuccess extends UserProfileManagementState {}

final class UserProfileManagementError extends UserProfileManagementState {
  final String errMessage;
  const UserProfileManagementError(this.errMessage);

  @override
  List<Object?> get props => [errMessage];
}
