import 'package:flo_wallet/features/home/injection/home_di.dart';

import 'core_di.dart';
import '../../features/auth/injection/auth_di.dart';
import '../../features/wallet/injection/wallet_di.dart';
import '../../features/transactions/injection/transaction_di.dart';
import '../../features/user/injection/user_di.dart';

void setupServiceLocator() {
  setupCoreDI();
  setupAuthDI();
  setupWalletDI();
  setupTransactionDI();
  setupUserDI();
  setupHomeDI();
}
