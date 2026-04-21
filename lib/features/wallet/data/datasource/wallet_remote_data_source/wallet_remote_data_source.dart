import 'package:flo_wallet/features/wallet/data/models/wallet_model.dart';

abstract class WalletRemoteDataSource {
  Future<WalletModel> getWallet({required String uId});
   Future<void> createWallet({required WalletModel wallet});
}
