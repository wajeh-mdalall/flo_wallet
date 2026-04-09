import 'package:flo_wallet/core/errors/failures/failure.dart';

abstract class AuthFailure extends Failure {
  const AuthFailure(super.errMessage);
}

class InvalidPhoneNumberFailure extends AuthFailure {
  const InvalidPhoneNumberFailure()
    : super("The phone number is invalid. Please check and try again.");
}

class TooManyRequestsFailure extends AuthFailure {
  const TooManyRequestsFailure()
    : super("Too many requests. Please wait and try again later.");
}

class InvalidVerificationCodeFailure extends AuthFailure {
  const InvalidVerificationCodeFailure()
    : super("The verification code is incorrect. Please try again.");
}

class SessionExpiredFailure extends AuthFailure {
  const SessionExpiredFailure()
    : super("The verification session has expired. Please request a new code.");
}

class AuthGenericFailure extends AuthFailure {
  const AuthGenericFailure()
    : super("Authentication failed. Please try again.");
}

class OperationNotAllowedFailure extends AuthFailure {
  const OperationNotAllowedFailure()
    : super("This service is not available in your region.");
}

class QuotaExceededFailure extends AuthFailure {
  const QuotaExceededFailure()
    : super(
        "SMS quota has been exceeded. Please try again tomorrow or contact support.",
      );
}

class UserDisabledFailure extends AuthFailure {
  const UserDisabledFailure()
    : super(
        "This account has been disabled. Please contact support for assistance.",
      );
}
