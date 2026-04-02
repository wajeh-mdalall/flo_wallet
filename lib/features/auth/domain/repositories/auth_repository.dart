import 'package:dartz/dartz.dart';
import 'package:flo_wallet/features/auth/domain/entities/phone_auth_step_entity.dart';
import '../../../../core/errors/failure.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, PhoneAuthStepEntity>> sendPhoneNumber({
    required String phoneNumber,
    int? forceResendingToken,
  });
  Future<Either<Failure, UserEntity>> confirmOtp({
    required String verificationId,
    required String smsCode,
  });
  // ! auto-login
  Future<Either<Failure, UserEntity?>> getCurrentUser();
  Future<Either<Failure, Unit>> signOut();
}
