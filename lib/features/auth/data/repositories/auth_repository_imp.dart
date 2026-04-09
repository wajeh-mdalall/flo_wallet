import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flo_wallet/features/auth/errors/exceptions/auth_exception.dart';
import '../../../../core/cache/cache_helper.dart';
import '../../../../core/constants.dart';
import '../../../../core/errors/failures/failure.dart';
import '../../../../core/network/network_info.dart';
import '../datasource/auth_remote_data_source/auth_remote_data_source.dart';
import '../models/user_model.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/entities/phone_auth_step_entity.dart';
import '../../domain/repositories/auth_repository.dart';

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
            completer.complete(left(_handleAuthError(exception)));
          }
        },
        codeAutoRetrievalTimeout: (_) {},
        onVerificationCompleted: (credential) async {
          if (!completer.isCompleted) {
            final userModel = await remoteDataSource.signInWithCredential(
              credential,
            );
            await cacheHelper.saveData(key:AppConstants.uidKey, value: userModel.uId);

            completer.complete(Right(AutoVerifiedSuccess(userModel)));
          }
        },
      );
    } catch (e) {
      if (!completer.isCompleted) {
        completer.complete(left(_handleAuthError(e)));
      }
    }
    return completer.future.timeout(
      AppConstants.timeOut,
      onTimeout: () => left(TimeOutFailure()),
    );
  }

  @override
  Future<Either<Failure, UserEntity>> confirmOtp({
    required String verificationId,
    required String smsCode,
  }) async {
    if (!await networkInfo.isConnected) {
      return left(OfflineFailure());
    }
    try {
      final UserModel user = await remoteDataSource.confirmWithSmsCode(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      await cacheHelper.saveData(key: AppConstants.uidKey, value: user.uId);
      return right(user);
    } catch (e) {
      return left(_handleAuthError(e));
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> getCurrentUser() async {
    try {
      UserModel? user = remoteDataSource.getCurrentFirebaseUser();
      if (user == null) {
        return right(null);
      }
      return right(user);
    } catch (e) {
      return left(_handleAuthError(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> signOut() async {
    try {
      await remoteDataSource.signOut();
      await cacheHelper.removeData(key: AppConstants.uidKey);
      return right(unit);
    } catch (e) {
      return left(_handleAuthError(e));
    }
  }

  Failure _handleAuthError(Object e) {
    if (e is AuthException) {
      return e.failure;
    }
    return ServerFailure();
  }
}
