import 'package:dartz/dartz.dart';
import 'package:flo_wallet/core/errors/failures/failure.dart';
import 'package:flo_wallet/features/user/domain/repositories/user_repository.dart';

class UpdateFcmTokenUsecase {
  final UserRepository userRepository;
  const UpdateFcmTokenUsecase({required this.userRepository});
  Future<Either<Failure, Unit>> call({required String uId,
    required String token,}) async {
    return await userRepository.updateFcmToken(uId: uId,token: token);
  }
}