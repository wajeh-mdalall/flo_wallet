import 'package:dartz/dartz.dart';
import 'package:flo_wallet/features/auth/domain/entities/phone_auth_step_entity.dart';
import '../../../../core/errors/failures/failure.dart';
import '../repositories/auth_repository.dart';

class SendPhoneNumberUseCase {
  final AuthRepository authRepositories;

  const SendPhoneNumberUseCase({required this.authRepositories});
  Future<Either<Failure, PhoneAuthStepEntity>> call({
    required String phoneNumber,
    int? forceResendingToken,
  }) async {
    return await authRepositories.sendPhoneNumber(
      phoneNumber: phoneNumber,
      forceResendingToken: forceResendingToken,
    );
  }
}
