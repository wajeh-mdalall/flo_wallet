import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures/failure.dart';
import '../entities/auth_user_entity.dart';
import '../repositories/auth_repository.dart';

class ConfirmOtpUseCase {
  final AuthRepository authRepository;

  ConfirmOtpUseCase({required this.authRepository});
  Future<Either<Failure, AuthUserEntity>> call({
    required String verificationId,
    required String smsCode,
  }) async {
    return await authRepository.confirmOtp(
      verificationId: verificationId,
      smsCode: smsCode,
    );
  }
}
