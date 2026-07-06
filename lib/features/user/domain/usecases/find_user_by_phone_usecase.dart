import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures/failure.dart';
import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

class FindUserByPhoneUsecase {
  final UserRepository userRepository;
  const FindUserByPhoneUsecase({required this.userRepository});
  Future<Either<Failure, UserEntity>> call({
    required String phoneNumber,
  }) async {
    return await userRepository.findUserByPhone(phoneNumber: phoneNumber);
  }
}
