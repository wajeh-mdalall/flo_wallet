import 'dart:io';

import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures/failure.dart';
import '../entities/user_entity.dart';

abstract class UserRepository {
  Future<Either<Failure, Unit>> uploadUserData({required UserEntity user});
  Future<Either<Failure, UserEntity>> getUserData({required String uId});
  Future<Either<Failure, Unit>> updateProfile({required UserEntity user});
  Future<Either<Failure, String>> uploadImage({
    required File file,
    required String path,
  });
  Future<Either<Failure, UserEntity>> findUserByPhone({
    required String phoneNumber,
  });
  Future<Either<Failure, Unit>> updateFcmToken({
    required String uId,
    required String token,
  });
}
