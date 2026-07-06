import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures/failure.dart';
import '../entities/wallet_entity.dart';
import '../repositories/wallet_repository.dart';

class WatchWalletUsecase {
  final WalletRepository walletRepository;

  const WatchWalletUsecase({required this.walletRepository});

  Stream<Either<Failure, WalletEntity>> call({required String uId})  {
    return walletRepository.watchWallet(uId: uId);
  }
}
