import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../../core/errors/exceptions/firestore_exception.dart';
import '../../../../../core/errors/handler/exception_handler.dart';
import 'wallet_remote_data_source.dart';
import '../../models/wallet_model.dart';
import '../../../../../core/errors/failures/firestore_failure.dart';
import '../../../wallet_firestore_keys.dart';

class WalletRemoteDataSourceImp implements WalletRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Future<void> createWallet({required WalletModel wallet}) async {
    try {
      await _firestore
          .collection(WalletFirestoreKeys.collectionName)
          .doc(wallet.uId)
          .set(wallet.toJson());
    } catch (e) {
      throw ExceptionHandler.handleFirestoreError(e);
    }
  }

  @override
  Future<WalletModel> getWallet({required String uId}) async {
    try {
      final docSnapshot = await _firestore
          .collection(WalletFirestoreKeys.collectionName)
          .doc(uId)
          .get();

      if (docSnapshot.exists) {
        return WalletModel.fromJson(jsonWallet: docSnapshot.data()!);
      } else {
        throw FirestoreException(DocumentNotFoundFailure());
      }
    } catch (e) {
      throw ExceptionHandler.handleFirestoreError(e);
    }
  }
}
