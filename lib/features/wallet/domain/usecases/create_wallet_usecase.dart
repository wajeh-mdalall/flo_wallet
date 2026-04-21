import 'package:dartz/dartz.dart';
import 'package:flo_wallet/core/errors/failures/failure.dart';
import 'package:flo_wallet/features/wallet/domain/repositories/wallet_repository.dart';

class CreateWalletUsecase {
  final WalletRepository walletRepository;
  const CreateWalletUsecase({required this.walletRepository});
  Future<Either<Failure, Unit>> call({required String userId})async {
    return await walletRepository.createWallet(userId: userId);
  }
}
