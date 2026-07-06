import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flo_wallet/core/firestore_keys.dart';
import '../../../../core/errors/exceptions/firestore_exception.dart';
import '../../../../core/errors/failures/firestore_failure.dart';
import '../../../../core/errors/handler/exception_handler.dart';
import 'user_remote_data_source.dart';
import '../models/user_model.dart';

class UserRemoteDataSourceImp implements UserRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<UserModel> getUserData({required String uId}) async {
    try {
      final docSnapshot = await _firestore
          .collection(FirestoreCollections.users)
          .doc(uId)
          .get();

      if (docSnapshot.exists) {
        return UserModel.fromFirestore(docSnapshot.data()!);
      }
      throw FirestoreException(DocumentNotFoundFailure());
    } catch (e) {
      throw ExceptionHandler.handleFirestoreError(e);
    }
  }

  @override
  Future<void> updateProfile({required UserModel user}) async {
    try {
      await _firestore
          .collection(FirestoreCollections.users)
          .doc(user.uId)
          .update(user.toJson());
    } catch (e) {
      throw ExceptionHandler.handleFirestoreError(e);
    }
  }

  @override
  Future<void> uploadUserData({required UserModel user}) async {
    try {
      await _firestore
          .collection(FirestoreCollections.users)
          .doc(user.uId)
          .set(user.toJson());
    } catch (e) {
      throw ExceptionHandler.handleFirestoreError(e);
    }
  }

  @override
  Future<UserModel> findUserByPhone({required String phoneNumber}) async {
    try {
      final querySnapshot = await _firestore
          .collection(FirestoreCollections.users)
          .where(UserFirestoreKeys.phoneNumber, isEqualTo: phoneNumber)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return UserModel.fromFirestore(querySnapshot.docs.first.data());
      } else {
        throw FirestoreException(
          DocumentNotFoundFailure(
            "The user does not exist, please verify the entered number.",
          ),
        );
      }
    } catch (e) {
      throw ExceptionHandler.handleFirestoreError(e);
    }
  }
}
