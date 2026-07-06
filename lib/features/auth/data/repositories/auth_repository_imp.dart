import 'dart:async';

import 'package:dartz/dartz.dart';

import '../../../../core/cache/cache_helper.dart';
import '../../../../core/constants.dart';
import '../../../../core/errors/failures/failure.dart';
import '../../../../core/errors/handler/exception_handler.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/auth_user_entity.dart';
import '../../domain/entities/phone_auth_step_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasource/auth_remote_data_source/auth_remote_data_source.dart';
import '../models/auth_user_model.dart';

class AuthRepositoryImp implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  final CacheHelper cacheHelper;

  AuthRepositoryImp({
    required this.remoteDataSource,
    required this.networkInfo,
    required this.cacheHelper,
  });
  @override
  Future<Either<Failure, PhoneAuthStepEntity>> sendPhoneNumber({
    required String phoneNumber,
    int? forceResendingToken,
  }) async {
    if (!await networkInfo.isConnected) {
      return left(OfflineFailure());
    }
    final Completer<Either<Failure, PhoneAuthStepEntity>> completer =
        Completer();
    try {
      await remoteDataSource.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        forceResendingToken: forceResendingToken,
        onCodeSent: (verificationId, resendToken) {
          if (!completer.isCompleted) {
            completer.complete(
              Right(
                VerificationCodeSent(
                  verificationId: verificationId,
                  phoneNumber: phoneNumber,
                  resendToken: resendToken,
                ),
              ),
            );
          }
        },
        onVerificationFailed: (exception) {
          if (!completer.isCompleted) {
            completer.complete(
              left(ExceptionHandler.exceptionToFailure(exception)),
            );
          }
        },
        codeAutoRetrievalTimeout: (_) {},
        onVerificationCompleted: (credential) async {
          if (!completer.isCompleted) {
            final AuthUserModel user = await remoteDataSource
                .signInWithCredential(credential);
            await cacheHelper.saveData(
              key: AppConstants.uIdKey,
              value: user.uId,
            );

            completer.complete(Right(AutoVerifiedSuccess(user)));
          }
        },
      );
    } catch (e) {
      if (!completer.isCompleted) {
        completer.complete(left(ExceptionHandler.exceptionToFailure(e)));
      }
    }
    return completer.future.timeout(
      AppConstants.timeOut,
      onTimeout: () => left(TimeOutFailure()),
    );
  }

  @override
  Future<Either<Failure, AuthUserEntity>> confirmOtp({
    required String verificationId,
    required String smsCode,
  }) async {
    if (!await networkInfo.isConnected) {
      return left(OfflineFailure());
    }
    try {
      final AuthUserModel user = await remoteDataSource.confirmWithSmsCode(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      await cacheHelper.saveData(key: AppConstants.uIdKey, value: user.uId);
      return right(user);
    } catch (e) {
      return left(ExceptionHandler.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, AuthUserEntity?>> getCurrentUser() async {
    try {
      final AuthUserModel? user = remoteDataSource.getCurrentFirebaseUser();
      if (user == null) {
        return right(null);
      }
      return right(user);
    } catch (e) {
      return left(ExceptionHandler.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> signOut() async {
    try {
      await remoteDataSource.signOut();
      await cacheHelper.removeData(key: AppConstants.uIdKey);
      return right(unit);
    } catch (e) {
      return left(ExceptionHandler.exceptionToFailure(e));
    }
  }
}
