import 'package:dartz/dartz.dart';
import 'package:flo_wallet/core/errors/failures/failure.dart';
import 'package:flo_wallet/core/errors/handler/exception_handler.dart';
import 'package:flo_wallet/core/network/network_info.dart';
import 'package:flo_wallet/features/wallet/data/datasource/wallet_remote_data_source/wallet_remote_data_source.dart';
import 'package:flo_wallet/features/wallet/data/models/wallet_model.dart';
import 'package:flo_wallet/features/wallet/domain/entities/wallet_entity.dart';
import 'package:flo_wallet/features/wallet/domain/repositories/wallet_repository.dart';

class WalletRepositoryImp implements WalletRepository {
  final WalletRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  WalletRepositoryImp({
    required this.remoteDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, Unit>> createWallet({
    required String userId,
  }) async {
    if (!await networkInfo.isConnected) {
      return left(OfflineFailure());
    }
    try {
      final WalletModel newWallet = WalletModel.initial(userId);
      await remoteDataSource.createWallet(wallet: newWallet);
      return right(unit);
    } catch (e) {
      return left(ExceptionHandler.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, WalletEntity>> getWallet({
    required String userId,
  }) async {
    if (!await networkInfo.isConnected) {
      return left(OfflineFailure());
    }
    try {
      final WalletModel walletModel = await remoteDataSource.getWallet(
        uId: userId,
      );
      return right(walletModel);
    } catch (e) {
      return left(ExceptionHandler.exceptionToFailure(e));
    }
  }
}
