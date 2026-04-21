part of 'transactions_cubit.dart';

sealed class TransactionsState extends Equatable {
  const TransactionsState();

  @override
  List<Object> get props => [];
}

final class TransactionsInitial extends TransactionsState {}

final class TransactionsLoading extends TransactionsState {}

final class TransactionsLoaded extends TransactionsState {
  final List<TransactionEntity> transactions;
  const TransactionsLoaded(this.transactions);

  @override
  List<Object> get props => [transactions];
}

final class TransactionsError extends TransactionsState {
  final String errMessage;
  const TransactionsError(this.errMessage);

  @override
  List<Object> get props => [errMessage];
}
