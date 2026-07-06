import 'package:firebase_auth/firebase_auth.dart';
import '../exceptions/firestore_exception.dart';
import '../failures/failure.dart';
import '../failures/firestore_failure.dart';
import 'firestore_exception_handler.dart';
import '../exceptions/auth_exception.dart';

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
    if (e is FirestoreException) {
      return e;
    }
    if (e is ArgumentError) {
      return FirestoreException(EmptyUidFailure());
    }
    if (e is FirebaseException) {
      Failure failure = FirestoreExceptionHandler.handle(e);
      return FirestoreException(failure);
    }
    return FirestoreException(ServerFailure());
  }
}
