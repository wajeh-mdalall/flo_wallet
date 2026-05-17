import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures/failure.dart';
import '../entities/wallet_entity.dart';

abstract class WalletRepository {
  Future<Either<Failure, Unit>> createWallet({required String uId});
  Future<Either<Failure, WalletEntity>> getWallet({required String uId});
}
