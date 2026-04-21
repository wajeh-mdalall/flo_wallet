import 'package:flo_wallet/core/errors/failures/failure.dart';

abstract class FirestoreFailure extends Failure {
  const FirestoreFailure(super.errMessage);
}

class PermissionDeniedFailure extends FirestoreFailure {
  const PermissionDeniedFailure() : super("You don't have permission to access this data.");
}



class DocumentNotFoundFailure extends FirestoreFailure {
  const DocumentNotFoundFailure() : super("The requested data was not found.");
}



class FirestoreGenericFailure extends FirestoreFailure {
  const FirestoreGenericFailure() : super("Something went wrong with the database. Please try again.");
}