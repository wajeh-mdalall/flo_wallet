import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures/failure.dart';
import '../../../../core/errors/handler/exception_handler.dart';
import '../../../../core/network/network_info.dart';
import '../datasource/wallet_remote_data_source/wallet_remote_data_source.dart';
import '../models/wallet_model.dart';
import '../../domain/entities/wallet_entity.dart';
import '../../domain/repositories/wallet_repository.dart';

class WalletRepositoryImp implements WalletRepository {
  final WalletRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  WalletRepositoryImp({
    required this.remoteDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, Unit>> createWallet({required String uId}) async {
    if (!await networkInfo.isConnected) {
      return left(OfflineFailure());
    }
    try {
      final WalletModel newWallet = WalletModel.initial(uId);
      await remoteDataSource.createWallet(wallet: newWallet);
      return right(unit);
    } catch (e) {
      return left(ExceptionHandler.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, WalletEntity>> getWallet({required String uId}) async {
    if (!await networkInfo.isConnected) {
      return left(OfflineFailure());
    }
    try {
      final WalletModel walletModel = await remoteDataSource.getWallet(
        uId: uId,
      );
      return right(walletModel);
    } catch (e) {
      return left(ExceptionHandler.exceptionToFailure(e));
    }
  }
}
