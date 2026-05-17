import 'package:firebase_auth/firebase_auth.dart';
import '../../models/auth_user_model.dart';
import '../../../../../core/errors/exceptions/auth_exception.dart';

abstract class AuthRemoteDataSource {
  Future<void> verifyPhoneNumber({
    required String phoneNumber,
    int? forceResendingToken,
    required void Function(String verificationId, int? resendToken) onCodeSent,
    required void Function(AuthException) onVerificationFailed,
    required void Function(String) codeAutoRetrievalTimeout,
    required void Function(PhoneAuthCredential) onVerificationCompleted,
  });
  Future<AuthUserModel> confirmWithSmsCode({
    required String verificationId,
    required String smsCode,
  });
  Future<AuthUserModel> signInWithCredential(PhoneAuthCredential credential);
  AuthUserModel? getCurrentFirebaseUser();
  Future<void> signOut();
}
