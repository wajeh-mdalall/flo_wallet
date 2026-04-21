import 'package:firebase_auth/firebase_auth.dart';
import 'package:flo_wallet/core/errors/failures/failure.dart';
import '../failures/firestore_failure.dart';

class FirestoreExceptionHandler {
  static Failure handle(FirebaseException e) {
    return switch (e.code) {
      'permission-denied' => PermissionDeniedFailure(),
      'unavailable' => OfflineFailure(),
      'not-found' => DocumentNotFoundFailure(),
      'deadline-exceeded' => ServerFailure(),
      _ => FirestoreGenericFailure(),
    };
  }
}
