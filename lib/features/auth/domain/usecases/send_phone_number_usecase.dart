import 'package:dartz/dartz.dart';
import '../entities/phone_auth_step_entity.dart';
import '../../../../core/errors/failures/failure.dart';
import '../repositories/auth_repository.dart';

class SendPhoneNumberUseCase {
  final AuthRepository authRepository;

  const SendPhoneNumberUseCase({required this.authRepository});
  Future<Either<Failure, PhoneAuthStepEntity>> call({
    required String phoneNumber,
    int? forceResendingToken,
  }) async {
    return await authRepository.sendPhoneNumber(
      phoneNumber: phoneNumber,
      forceResendingToken: forceResendingToken,
    );
  }
}
