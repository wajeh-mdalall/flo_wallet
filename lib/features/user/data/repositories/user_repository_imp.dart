import 'dart:io';

import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures/failure.dart';
import '../../../../core/errors/handler/exception_handler.dart';
import '../../../../core/helper/image_upload_helper.dart';
import '../../../../core/network/network_info.dart';
import '../datasource/user_remote_data_source.dart';
import '../models/user_model.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';

class UserRepositoryImp implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final ImageUploadHelper imageUploadHelper;
  final NetworkInfo networkInfo;

  UserRepositoryImp({
    required this.remoteDataSource,
    required this.networkInfo,
    required this.imageUploadHelper,
  });

  @override
  Future<Either<Failure, UserEntity>> getUserData({required String uId}) async {
    if (!await networkInfo.isConnected) {
      return left(OfflineFailure());
    }
    try {
      final UserModel user = await remoteDataSource.getUserData(uId: uId);
      return right(user);
    } catch (e) {
      return left(ExceptionHandler.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateProfile({
    required UserEntity user,
  }) async {
    if (!await networkInfo.isConnected) {
      return left(OfflineFailure());
    }
    try {
      final UserModel userModel = UserModel(
        uId: user.uId,
        phoneNumber: user.phoneNumber,
        name: user.name,
        profileImageUrl: user.profileImageUrl,
        dateOfBirth: user.dateOfBirth,
        country: user.country,
      );
      await remoteDataSource.updateProfile(user: userModel);
      return right(unit);
    } catch (e) {
      return left(ExceptionHandler.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> uploadUserData({
    required UserEntity user,
  }) async {
    if (!await networkInfo.isConnected) {
      return left(OfflineFailure());
    }
    try {
      final UserModel userModel = UserModel(
        uId: user.uId,
        phoneNumber: user.phoneNumber,
        name: user.name,
        profileImageUrl: user.profileImageUrl,
        dateOfBirth: user.dateOfBirth,
        country: user.country,
      );
      await remoteDataSource.uploadUserData(user: userModel);
      return right(unit);
    } catch (e) {
      return left(ExceptionHandler.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, String>> uploadImage({
    required File file,
    required String path,
  }) async {
    if (!await networkInfo.isConnected) {
      return left(OfflineFailure());
    }
    try {
      final String imageUrl = await imageUploadHelper.uploadImage(
        file: file,
        path: path,
      );
      return right(imageUrl);
    } catch (e) {
      return left(ImageFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> findUserByPhone({
    required String phoneNumber,
  }) async {
    try {
      final user = await remoteDataSource.findUserByPhone(
        phoneNumber: phoneNumber,
      );
      return right(user);
    } catch (e) {
      return left(ExceptionHandler.exceptionToFailure(e));
    }
  }@override
Future<Either<Failure, Unit>> updateFcmToken({
  required String uId,
  required String token,
}) async {
  try {
    await remoteDataSource.updateFcmToken(uId: uId, token: token);
    return const Right(unit);
  } catch (e) {
    return Left(ExceptionHandler.exceptionToFailure(e));
  }
}
}
