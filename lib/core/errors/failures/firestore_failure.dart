import 'failure.dart';

abstract class FirestoreFailure extends Failure {
  const FirestoreFailure(super.errMessage);
}

class PermissionDeniedFailure extends FirestoreFailure {
  const PermissionDeniedFailure()
    : super("You don't have permission to access this data.");
}

class DocumentNotFoundFailure extends FirestoreFailure {
  const DocumentNotFoundFailure([
    super.errMessage = "The requested data was not found.",
  ]);
  @override
  bool get requiresSignIn => true;
}

class EmptyUidFailure extends FirestoreFailure {
  const EmptyUidFailure()
    : super("User ID does not exist, please log in again.");
  @override
  bool get requiresSignIn => true;
}

class InsufficientBalanceFailure extends FirestoreFailure {
  const InsufficientBalanceFailure()
    : super(
        "Your current balance is insufficient to complete this transaction.",
      );
}

class FirestoreGenericFailure extends FirestoreFailure {
  const FirestoreGenericFailure()
    : super("Something went wrong with the database. Please try again.");
}
