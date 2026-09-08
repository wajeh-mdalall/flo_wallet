import 'package:dartz/dartz.dart';
import 'package:flo_wallet/features/user/domain/usecases/get_user_data_usecase.dart';
import '../../domain/entities/phone_auth_step_entity.dart';
import '../../../../core/errors/failures/failure.dart';
import '../../domain/entities/auth_user_entity.dart';
import '../../domain/usecases/confirm_otp_usecase.dart';
import '../../domain/usecases/get_current_user_usecase.dart';
import '../../domain/usecases/send_phone_number_usecase.dart';
import '../../domain/usecases/sign_out_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  int? _resendToken;
  final SendPhoneNumberUseCase sendPhoneNumberUseCase;
  final ConfirmOtpUseCase confirmOtpUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final SignOutUseCase signOutUseCase;
  final GetUserDataUsecase getUserDataUsecase;
  AuthCubit({
    required this.sendPhoneNumberUseCase,
    required this.confirmOtpUseCase,
    required this.getCurrentUserUseCase,
    required this.signOutUseCase,
    required this.getUserDataUsecase,
  }) : super(AuthInitial());

  Future<bool> _checkIsProfileComplete(String uId) async {
    final result = await getUserDataUsecase(uId: uId);
    return result.isRight();
  }

  Future<void> sendPhoneNumber({required String phoneNumber}) async {
    emit(AuthLoading());
    final Either<Failure, PhoneAuthStepEntity> result =
        await sendPhoneNumberUseCase(
          phoneNumber: phoneNumber,
          forceResendingToken: _resendToken,
        );
    result.fold(
      (failure) {
        emit(AuthError(failure.errMessage));
      },
      (authStep) async {
        switch (authStep) {
          case VerificationCodeSent():
            _resendToken = authStep.resendToken;
            emit(CodeSent(authStep));
          case AutoVerifiedSuccess():
            emit(AutoVerifying());
            final isComplete = await _checkIsProfileComplete(authStep.user.uId);
            Future.delayed(Duration(milliseconds: 500), () {
              if (!isClosed) {
                emit(
                  Authenticated(
                    authUser: authStep.user,
                    isProfileComplete: isComplete,
                  ),
                );
              }
            });
        }
      },
    );
  }

  Future<void> confirmOtp(String verificationId, String smsCode) async {
    emit(AuthLoading());
    final Either<Failure, AuthUserEntity> result = await confirmOtpUseCase(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    result.fold((failure) => emit(AuthError(failure.errMessage)), (user) async {
      final isComplete = await _checkIsProfileComplete(user.uId);
      emit(Authenticated(authUser: user, isProfileComplete: isComplete));
    });
  }

  Future<void> getCurrentUser() async {
    emit(AuthLoading());
    final Either<Failure, AuthUserEntity?> result =
        await getCurrentUserUseCase();
    result.fold((_) => emit(Unauthenticated()), (user) async {
      if (user != null) {
        final isComplete = await _checkIsProfileComplete(user.uId);
        emit(Authenticated(authUser: user, isProfileComplete: isComplete));
      } else {
        emit(Unauthenticated());
      }
    });
  }

  Future<void> signOut() async {
    emit(AuthLoading());
    final Either<Failure, Unit> result = await signOutUseCase();
    result.fold(
      (failure) => emit(AuthError(failure.errMessage)),
      (_) => emit(Unauthenticated()),
    );
  }
}
