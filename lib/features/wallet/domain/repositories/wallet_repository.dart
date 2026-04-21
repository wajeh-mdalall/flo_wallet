import 'package:dartz/dartz.dart';
import 'package:flo_wallet/core/errors/failures/failure.dart';
import 'package:flo_wallet/features/wallet/domain/entities/wallet_entity.dart';

abstract class WalletRepository {
  Future<Either<Failure, Unit>> createWallet({required String userId});
  Future<Either<Failure, WalletEntity>> getWallet({required String userId});

}
