import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures/failure.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class ConfirmOtpUseCase {
  final AuthRepository authRepositories;

  ConfirmOtpUseCase({required this.authRepositories});
  Future<Either<Failure, UserEntity>> call({
    required String verificationId,
    required String smsCode,
  }) async {
    return await authRepositories.confirmOtp(
      verificationId: verificationId,
      smsCode: smsCode,
    );
  }
}
