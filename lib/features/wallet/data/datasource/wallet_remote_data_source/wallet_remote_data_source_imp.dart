import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flo_wallet/core/firestore_keys.dart';
import '../../../../../core/errors/exceptions/firestore_exception.dart';
import '../../../../../core/errors/handler/exception_handler.dart';
import 'wallet_remote_data_source.dart';
import '../../models/wallet_model.dart';
import '../../../../../core/errors/failures/firestore_failure.dart';

class WalletRemoteDataSourceImp implements WalletRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Future<void> createWallet({required WalletModel wallet}) async {
    try {
      await _firestore
          .collection(FirestoreCollections.wallets)
          .doc(wallet.uId)
          .set(wallet.toJson());
    } catch (e) {
      throw ExceptionHandler.handleFirestoreError(e);
    }
  }

  @override
  Stream<WalletModel> watchWallet({required String uId}) {
    return _firestore
        .collection(FirestoreCollections.wallets)
        .doc(uId)
        .snapshots()
        .map((docSnapshot) {
          if (docSnapshot.exists) {
            return WalletModel.fromFirestore(jsonWallet: docSnapshot.data()!);
          } else {
            throw FirestoreException(DocumentNotFoundFailure());
          }
        })
        .handleError((e) {
          throw ExceptionHandler.handleFirestoreError(e);
        });
  }
}
