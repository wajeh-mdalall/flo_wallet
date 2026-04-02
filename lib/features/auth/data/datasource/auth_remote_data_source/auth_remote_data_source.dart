import 'package:firebase_auth/firebase_auth.dart';
import 'package:flo_wallet/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<void> verifyPhoneNumber({
    required String phoneNumber,
    int? forceResendingToken,
    required void Function(String verificationId, int? resendToken) onCodeSent,
    required void Function(FirebaseAuthException) onVerificationFailed,
    required void Function(String) codeAutoRetrievalTimeout,
    required void Function(PhoneAuthCredential) onVerificationCompleted,
  });
  Future<UserModel> confirmWithSmsCode({
    required String verificationId,
    required String smsCode,
  });
  Future<UserModel> signInWithCredential(PhoneAuthCredential credential);
  UserModel? getCurrentFirebaseUser();
  Future<void> signOut();
}
