import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flo_wallet/core/errors/failures/failure.dart';
import 'package:flo_wallet/features/transactions/domain/entities/transactions_entity.dart';
import 'package:flo_wallet/features/transactions/domain/usecases/get_transactions/get_transactions_params.dart';
import 'package:flo_wallet/features/transactions/domain/usecases/get_transactions/watch_latest_transactions_usecase.dart';
import 'package:flo_wallet/features/user/domain/entities/user_entity.dart';
import 'package:flo_wallet/features/user/domain/usecases/get_user_data_usecase.dart';
import 'package:flo_wallet/features/wallet/domain/entities/wallet_entity.dart';
import 'package:flo_wallet/features/wallet/domain/usecases/get_wallet_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetUserDataUsecase getUserDataUsecase;
  final WatchWalletUsecase watchWalletUsecase;
  final WatchLatestTransactionsUsecase watchLatestTransactionsUsecase;

  // Active stream subscription to prevent memory leaks
  StreamSubscription? _walletSubscription;
  StreamSubscription? _transactionsSubscription;

  HomeCubit({
    required this.getUserDataUsecase,
    required this.watchWalletUsecase,
    required this.watchLatestTransactionsUsecase,
  }) : super(HomeState.initial());

  Future<void> fetchHomeData({required String uId}) async {
    emit(state.copyWith(status: HomeStatus.loading));

    // Fetch static user data once via Future
    final Either<Failure, UserEntity> userResult = await getUserDataUsecase(
      uId: uId,
    );

    userResult.fold(
      (failure) => emit(
        state.copyWith(
          status: HomeStatus.failure,
          errMessage: failure.errMessage,
          requiresSignIn: failure.requiresSignIn,
        ),
      ),
      (user) {
        emit(state.copyWith(user: user));
        // Start dual live sync for wallet and transactions upon successful user fetch
        _startListeningToLiveUpdates(uId: uId);
      },
    );
  }

  void _startListeningToLiveUpdates({required String uId}) {
    // Cancel any existing subscription before starting a new one
    _walletSubscription?.cancel();
    _transactionsSubscription?.cancel();
    // Listen to real-time wallet balance updates
    _walletSubscription = watchWalletUsecase(uId: uId).listen((walletResult) {
      walletResult.fold(
        (failure) {
          emit(
            state.copyWith(
              status: HomeStatus.failure,
              errMessage: failure.errMessage,
              requiresSignIn: failure.requiresSignIn,
            ),
          );
        },
        (liveWallet) {
          // Seamlessly update wallet while retaining user and transaction history
          emit(state.copyWith(status: HomeStatus.success, wallet: liveWallet));
        },
      );
    });
    // Listen to real-time transaction updates (limited to 5)
    _transactionsSubscription =
        watchLatestTransactionsUsecase(
          GetTransactionsParams(uId: uId, limit: 5),
        ).listen((transactionsResult) {
          transactionsResult.fold(
            (failure) => emit(
              state.copyWith(
                status: HomeStatus.failure,
                errMessage: failure.errMessage,
                requiresSignIn: failure.requiresSignIn,
              ),
            ),
            // Seamlessly update transaction list while retaining user and wallet state
            (liveTransactions) => emit(
              state.copyWith(
                status: HomeStatus.success,
                transactions: liveTransactions,
              ),
            ),
          );
        });
  }

  @override
  Future<void> close() {
    // Prevents memory leaks and unnecessary data usage by closing all streams
    _walletSubscription?.cancel();
    _transactionsSubscription?.cancel();
    return super.close();
  }
}
