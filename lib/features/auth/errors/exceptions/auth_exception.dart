import 'package:flo_wallet/core/errors/failure.dart';

class AuthException implements Exception {
  final Failure failure;

  AuthException(this.failure);
}
