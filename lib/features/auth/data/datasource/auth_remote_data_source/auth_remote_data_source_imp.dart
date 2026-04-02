import 'package:firebase_auth/firebase_auth.dart';
import 'package:flo_wallet/core/errors/Exceptions/auth_exception.dart';
import 'package:flo_wallet/core/errors/failure.dart';
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
    required void Function(FirebaseAuthException) onVerificationFailed,
    required void Function(String) codeAutoRetrievalTimeout,
    required void Function(PhoneAuthCredential) onVerificationCompleted,
  }) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        forceResendingToken: forceResendingToken,
        timeout: AppConstants.timeOut,
        verificationFailed: onVerificationFailed,
        codeSent: onCodeSent,
        verificationCompleted: onVerificationCompleted,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      );
    } on FirebaseAuthException catch (e) {
      Failure failure = FirebaseAuthExceptionHandler.handle(e);
      throw AuthException(failure);
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
    } on FirebaseAuthException catch (e) {
      Failure failure = FirebaseAuthExceptionHandler.handle(e);
      throw AuthException(failure);
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
    } on FirebaseAuthException catch (e) {
      Failure failure = FirebaseAuthExceptionHandler.handle(e);
      throw AuthException(failure);
    }
  }

  @override
  UserModel? getCurrentFirebaseUser() {
    try {
      User? fbUser = _auth.currentUser;
      if (fbUser == null) return null;
      return UserModel.fromFirebaseUser(fbUser);
    } on FirebaseAuthException catch (e) {
      Failure failure = FirebaseAuthExceptionHandler.handle(e);
      throw AuthException(failure);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      Failure failure = FirebaseAuthExceptionHandler.handle(e);
      throw AuthException(failure);
    }
  }
}
