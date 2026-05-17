import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures/failure.dart';
import '../repositories/auth_repository.dart';

class SignOutUseCase {
  final AuthRepository authRepository;

  SignOutUseCase({required this.authRepository});
  Future<Either<Failure, Unit>> call() async {
    return await authRepository.signOut();
  }
}
