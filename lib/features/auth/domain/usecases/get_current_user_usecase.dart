import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures/failure.dart';
import '../entities/auth_user_entity.dart';
import '../repositories/auth_repository.dart';

class GetCurrentUserUseCase {
  final AuthRepository authRepository;

  GetCurrentUserUseCase({required this.authRepository});
  Future<Either<Failure, AuthUserEntity?>> call() async {
    return await authRepository.getCurrentUser();
  }
}
