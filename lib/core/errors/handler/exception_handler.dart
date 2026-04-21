import 'package:firebase_auth/firebase_auth.dart';
import 'package:flo_wallet/core/errors/exceptions/firestore_exception.dart';
import 'package:flo_wallet/core/errors/failures/failure.dart';
import 'package:flo_wallet/core/errors/handler/firestore_exception_handler.dart';
import 'package:flo_wallet/core/errors/exceptions/auth_exception.dart';

class ExceptionHandler {
  static Failure exceptionToFailure(Object e) {
    switch (e) {
      case FirestoreException _:
        return e.failure;
      case AuthException _:
        return e.failure;
      default:
        return ServerFailure();
    }
  }

  static FirestoreException handleFirestoreError(Object e) {
    if (e is FirebaseException) {
      Failure failure = FirestoreExceptionHandler.handle(e);
      return FirestoreException(failure);
    }
    return FirestoreException(ServerFailure());
  }
}
