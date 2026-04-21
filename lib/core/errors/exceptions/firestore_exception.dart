import 'package:flo_wallet/core/errors/failures/failure.dart';

class FirestoreException implements Exception {
  final Failure failure;

  FirestoreException(this.failure);
}
