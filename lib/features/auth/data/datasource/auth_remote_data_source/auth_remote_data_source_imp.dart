import 'package:firebase_auth/firebase_auth.dart';
import 'package:flo_wallet/core/errors/exceptions/auth_exception.dart';
import 'package:flo_wallet/core/errors/failures/failure.dart';
import 'package:flo_wallet/features/auth/data/models/user_model.dart';
import 'package:flo_wallet/features/auth/errors/handler/firebase_auth_exception_handler.dart';
import '../../../../../core/constants.dart';
import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImp implements AuthRemoteDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<void> verifyPhoneNumber({
    required String phoneNumber,
    int? forceResendingToken,
    required void Function(String verificationId, int? resendToken) onCodeSent,
    required void Function(AuthException) onVerificationFailed,
    required void Function(String) codeAutoRetrievalTimeout,
    required void Function(PhoneAuthCredential) onVerificationCompleted,
  }) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        forceResendingToken: forceResendingToken,
        timeout: AppConstants.timeOut,
        verificationFailed: (FirebaseAuthException e) {
          final AuthException translatedError = _handleAuthError(e);
          onVerificationFailed(translatedError);
        },
        codeSent: onCodeSent,
        verificationCompleted: onVerificationCompleted,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      );
    } catch (e) {
      throw _handleAuthError(e);
    }
  }

  @override
  Future<UserModel> confirmWithSmsCode({
    required String verificationId,
    required String smsCode,
  }) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );
      return UserModel.fromFirebaseUser(
        userCredential.user!,
        isNewUser: userCredential.additionalUserInfo?.isNewUser ?? false,
      );
    } catch (e) {
      throw _handleAuthError(e);
    }
  }

  @override
  Future<UserModel> signInWithCredential(PhoneAuthCredential credential) async {
    try {
      final userCredential = await _auth.signInWithCredential(credential);
      return UserModel.fromFirebaseUser(
        userCredential.user!,
        isNewUser: userCredential.additionalUserInfo!.isNewUser,
      );
    } catch (e) {
      throw _handleAuthError(e);
    }
  }

  @override
  UserModel? getCurrentFirebaseUser() {
    try {
      User? fbUser = _auth.currentUser;
      if (fbUser == null) return null;
      return UserModel.fromFirebaseUser(fbUser);
    } catch (e) {
      throw _handleAuthError(e);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw _handleAuthError(e);
    }
  }
}

AuthException _handleAuthError(Object e) {
  if (e is FirebaseAuthException) {
    Failure failure = FirebaseAuthExceptionHandler.handle(e);
    return AuthException(failure);
  }
  return AuthException(ServerFailure());
}
