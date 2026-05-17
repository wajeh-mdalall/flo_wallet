import 'package:dartz/dartz.dart';
import '../entities/phone_auth_step_entity.dart';
import '../../../../core/errors/failures/failure.dart';
import '../entities/auth_user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, PhoneAuthStepEntity>> sendPhoneNumber({
    required String phoneNumber,
    int? forceResendingToken,
  });
  Future<Either<Failure, AuthUserEntity>> confirmOtp({
    required String verificationId,
    required String smsCode,
  });
  // ! auto-login
  Future<Either<Failure, AuthUserEntity?>> getCurrentUser();
  Future<Either<Failure, Unit>> signOut();
}
