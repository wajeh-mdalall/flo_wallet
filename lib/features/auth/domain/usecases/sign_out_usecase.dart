import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures/failure.dart';
import '../repositories/auth_repository.dart';

class SignOutUseCase {
  final AuthRepository authRepositories;

  SignOutUseCase({required this.authRepositories});
  Future<Either<Failure, Unit>> call() async {
    return await authRepositories.signOut();
  }
}
