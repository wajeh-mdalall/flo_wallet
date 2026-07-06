import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures/failure.dart';
import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

class GetUserDataUsecase {
  final UserRepository userRepository;
  const GetUserDataUsecase({required this.userRepository});
  Future<Either<Failure, UserEntity>> call({required String uId}) async {
    return await userRepository.getUserData(uId: uId);
  }
}
