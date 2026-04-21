import 'package:dartz/dartz.dart';
import 'package:flo_wallet/core/errors/failures/failure.dart';
import 'package:flo_wallet/features/wallet/domain/entities/wallet_entity.dart';
import 'package:flo_wallet/features/wallet/domain/usecases/create_wallet_usecase.dart';
import 'package:flo_wallet/features/wallet/domain/usecases/get_wallet_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  final CreateWalletUsecase createWalletUsecase;
  final GetWalletUsecase getWalletUsecase;
  WalletCubit({
    required this.createWalletUsecase,
    required this.getWalletUsecase,
  }) : super(WalletInitial());
  Future<void> createWallet({required String userId}) async {
    emit(WalletLoading());
    Either<Failure, Unit> result = await createWalletUsecase(userId: userId);
    result.fold(
      (failure) {
        emit(WalletError(failure.errMessage));
      },
      (_) {
        emit(WalletCreated());
      },
    );
  }

  Future<void> getWallet({required String userId}) async {
    emit(WalletLoading());
    Either<Failure, WalletEntity> result = await getWalletUsecase(
      userId: userId,
    );
    result.fold(
      (failure) {
        emit(WalletError(failure.errMessage));
      },
      (wallet) {
        emit(WalletLoaded(wallet));
      },
    );
  }
}
