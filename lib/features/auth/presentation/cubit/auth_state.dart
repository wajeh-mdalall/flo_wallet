part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

//! After sendPhoneNumber
final class CodeSent extends AuthState {
  final VerificationCodeSent data;
  const CodeSent(this.data);
  @override
  List<Object> get props => [data];
}

//! After confirmOtp and getCurrentUser
final class Authenticated extends AuthState {
  final UserEntity user;
  const Authenticated(this.user);
  @override
  List<Object> get props => [user];
}
final class AutoVerifying extends AuthState {}
//! After signOut
final class Unauthenticated extends AuthState {}


final class AuthError extends AuthState {
  final String errMessage;
  const AuthError(this.errMessage);
  @override
  List<Object> get props => [errMessage];
}
