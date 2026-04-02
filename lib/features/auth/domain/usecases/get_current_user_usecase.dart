import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class GetCurrentUserUseCase {
  final AuthRepository authRepositories;

  GetCurrentUserUseCase({required this.authRepositories});
  Future<Either<Failure, UserEntity?>> call() async {
    return await authRepositories.getCurrentUser();
  }
}
