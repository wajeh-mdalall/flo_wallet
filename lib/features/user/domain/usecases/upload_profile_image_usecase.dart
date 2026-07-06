import 'dart:io';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures/failure.dart';
import '../repositories/user_repository.dart';

class UploadProfileImageUsecase {
  final UserRepository userRepository;
  UploadProfileImageUsecase({required this.userRepository});

  Future<Either<Failure, String>> call({
    required File file,
    required String path,
  }) {
    return userRepository.uploadImage(file: file, path: path);
  }
}
