import 'package:flo_wallet/features/transactions/domain/entities/transactions_entity.dart';
import 'package:flo_wallet/features/transactions/domain/usecases/get_transactions/get_transactions_paginated_usecase.dart';
import 'package:flo_wallet/features/transactions/domain/usecases/get_transactions/get_transactions_params.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'transactions_state.dart';

class TransactionsCubit extends Cubit<TransactionsState> {
  final GetTransactionsPaginatedUsecase getTransactionsPaginatedUsecase;
  String? _lastTransactionId;
  final int _pageLimit = 20;
  TransactionsCubit({required this.getTransactionsPaginatedUsecase})
    : super(TransactionsState.initial());
  Future<void> fetchTransactions({
    required String uId,
    bool isRefresh = false,
  }) async {
    if (isRefresh) {
      _lastTransactionId = null;
      emit(TransactionsState.initial());
    }

    if (state.status == TransactionsStatus.loading ||
        state.status == TransactionsStatus.loadingMore ||
        state.hasReachedMax) {
      return;
    }

    if (state.transactions.isNotEmpty) {
      emit(state.copyWith(status: TransactionsStatus.loadingMore));
    } else {
      emit(state.copyWith(status: TransactionsStatus.loading));
    }

    final result = await getTransactionsPaginatedUsecase(
      GetTransactionsParams(
        uId: uId,
        limit: _pageLimit,
        lastTransactionId: _lastTransactionId,
      ),
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: TransactionsStatus.failure,
          errMessage: failure.errMessage,
        ),
      ),
      (newTransactions) {
        if (newTransactions.isEmpty) {
          emit(
            state.copyWith(
              status: TransactionsStatus.success,
              hasReachedMax: true,
            ),
          );
          return;
        }
        _lastTransactionId = newTransactions.last.id;

        emit(
          state.copyWith(
            status: TransactionsStatus.success,
            transactions: List.of(state.transactions)..addAll(newTransactions),
            hasReachedMax: newTransactions.length < _pageLimit,
          ),
        );
      },
    );
  }
}
