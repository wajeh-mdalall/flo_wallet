import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures/failure.dart';
import '../repositories/wallet_repository.dart';

class CreateWalletUsecase {
  final WalletRepository walletRepository;
  const CreateWalletUsecase({required this.walletRepository});
  Future<Either<Failure, Unit>> call({required String uId}) async {
    return await walletRepository.createWallet(uId: uId);
  }
}
