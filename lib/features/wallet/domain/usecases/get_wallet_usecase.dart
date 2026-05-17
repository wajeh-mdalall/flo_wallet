import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures/failure.dart';
import '../entities/wallet_entity.dart';
import '../repositories/wallet_repository.dart';

class GetWalletUsecase {
  final WalletRepository walletRepository;

 const GetWalletUsecase({required this.walletRepository});

  Future<Either<Failure, WalletEntity>> call({required String uId}) async {
    return await walletRepository.getWallet(uId: uId);
  }
}
