import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/errors/failures/failure.dart';
import '../failures/auth_failure.dart';

class FirebaseAuthExceptionHandler {
  static Failure handle(FirebaseAuthException e) {
    return switch (e.code) {
      'invalid-phone-number' => InvalidPhoneNumberFailure(),
      'too-many-requests' => TooManyRequestsFailure(),
      'invalid-verification-code' => InvalidVerificationCodeFailure(),
      'session-expired' => SessionExpiredFailure(),
      'network-request-failed' => OfflineFailure(),
      'operation-not-allowed' => OperationNotAllowedFailure(),
      'quota-exceeded' => QuotaExceededFailure(), 
      'user-disabled' => UserDisabledFailure(),
      _ => AuthGenericFailure(),
    };
  }
}
