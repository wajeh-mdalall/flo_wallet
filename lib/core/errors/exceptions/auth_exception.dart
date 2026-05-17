import '../failures/failure.dart';

class AuthException implements Exception {
  final Failure failure;

  AuthException(this.failure);
}
