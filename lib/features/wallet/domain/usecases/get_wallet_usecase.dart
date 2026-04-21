import 'package:dartz/dartz.dart';
import 'package:flo_wallet/core/errors/failures/failure.dart';
import 'package:flo_wallet/features/wallet/domain/entities/wallet_entity.dart';
import 'package:flo_wallet/features/wallet/domain/repositories/wallet_repository.dart';

class GetWalletUsecase {
  final WalletRepository walletRepository;

 const GetWalletUsecase({required this.walletRepository});

  Future<Either<Failure, WalletEntity>> call({required String userId}) async{
    return await walletRepository.getWallet(userId: userId);
  }
}
