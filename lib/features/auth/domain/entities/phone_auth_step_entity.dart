import 'package:equatable/equatable.dart';
import 'auth_user_entity.dart';

sealed class PhoneAuthStepEntity extends Equatable {
  const PhoneAuthStepEntity();
  @override
  List<Object?> get props => [];
}

class VerificationCodeSent extends PhoneAuthStepEntity {
  final String verificationId;
  final String phoneNumber;
  final int? resendToken;

  const VerificationCodeSent({
    required this.verificationId,
    required this.phoneNumber,
    this.resendToken,
  });

  @override
  List<Object?> get props => [verificationId, phoneNumber, resendToken];
}

class AutoVerifiedSuccess extends PhoneAuthStepEntity {
  final AuthUserEntity user;

  const AutoVerifiedSuccess(this.user);
  @override
  List<Object?> get props => [user];
}
