part of 'transactions_cubit.dart';

enum TransactionsStatus { initial, loading, success, failure, loadingMore }

class TransactionsState extends Equatable {
  final TransactionsStatus status;
  final List<TransactionEntity> transactions;
  final bool hasReachedMax;
  final String? errMessage;
  const TransactionsState({
    required this.status,
    required this.transactions,
    required this.hasReachedMax,
    this.errMessage,
  });
  factory TransactionsState.initial() {
    return const TransactionsState(
      status: TransactionsStatus.initial,
      transactions: [],
      hasReachedMax: false,
    );
  }

  TransactionsState copyWith({
    TransactionsStatus? status,
    List<TransactionEntity>? transactions,
    bool? hasReachedMax,
    String? errMessage,
  }) {
    return TransactionsState(
      status: status ?? this.status,
      transactions: transactions ?? this.transactions,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errMessage: errMessage ?? this.errMessage,
    );
  }

  @override
  List<Object?> get props => [status, transactions, hasReachedMax, errMessage];
}
