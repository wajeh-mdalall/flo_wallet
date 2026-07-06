import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures/failure.dart';
import '../entities/wallet_entity.dart';

abstract class WalletRepository {
  Future<Either<Failure, Unit>> createWallet({required String uId});
  Stream<Either<Failure, WalletEntity>> watchWallet({required String uId});
}
