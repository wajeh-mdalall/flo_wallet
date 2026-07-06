import '../../models/wallet_model.dart';

abstract class WalletRemoteDataSource {
  Stream<WalletModel> watchWallet({required String uId});
  Future<void> createWallet({required WalletModel wallet});
}
