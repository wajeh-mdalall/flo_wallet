import '../../domain/entities/transactions_entity.dart';
import '../../domain/usecases/get_transactions/get_transactions_params.dart';
import '../../domain/usecases/get_transactions/get_transactions_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'transactions_state.dart';

class TransactionsCubit extends Cubit<TransactionsState> {
  final GetTransactionsUsecase getTransactionsUsecase;
  TransactionsCubit({required this.getTransactionsUsecase})
    : super(TransactionsInitial());
  Future<void> fetchTransactions({required String uId, int? limit}) async {
    emit(TransactionsLoading());
    final GetTransactionsParams params = GetTransactionsParams(
      uId: uId,
      limit: limit,
    );
    final result = await getTransactionsUsecase(params);
    result.fold(
      (failure) => emit(TransactionsError(failure.errMessage)),
      (transactions) => emit(TransactionsLoaded(transactions)),
    );
  }
}
