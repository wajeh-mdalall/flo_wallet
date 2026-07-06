import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures/failure.dart';
import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

class UpdateProfileUsecase {
  final UserRepository userRepository;
  const UpdateProfileUsecase({required this.userRepository});
  Future<Either<Failure, Unit>> call({required UserEntity user}) async {
    return await userRepository.uploadUserData(user: user);
  }
}
